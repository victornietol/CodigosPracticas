
import sys
from urllib.parse import urlparse

import vlc
import yt_dlp

from PySide6.QtCore import Qt, QThread, Signal, QTimer
from PySide6.QtWidgets import (
    QApplication,
    QMainWindow,
    QWidget,
    QVBoxLayout,
    QHBoxLayout,
    QLabel,
    QPushButton,
    QLineEdit,
    QSlider,
    QMessageBox,
)


class ExtractorWorker(QThread):
    # Resultado de la consulta
    success = Signal(dict)
    error = Signal(str)

    def __init__(self, url):
        super().__init__()
        self.url = url

    def run(self):
        try:
            domain = urlparse(self.url).hostname or ""

            options = {
                "quiet": True,
                "no_warnings": True,
                "noplaylist": True,
                "format": "bestaudio/best",
            }

            with yt_dlp.YoutubeDL(options) as ydl:
                info = ydl.extract_info(
                    self.url,
                    download=False
                )

            # No continuar si la fuente no proporciona un flujo directo.
            stream_url = info.get("url")

            if not stream_url:
                raise ValueError(
                    "No se encontró un flujo reproducible."
                )

            result = {
                "title": info.get("title", "Audio desconocido"),
                "duration": info.get("duration") or 0,
                "url": stream_url,
                "headers": info.get("http_headers") or {},
            }

            self.success.emit(result)

        except Exception as exc:
            self.error.emit(str(exc))


class Reproductor(QMainWindow):

    def __init__(self):
        super().__init__()

        self.setWindowTitle("Reproductor")
        self.resize(800, 550)
        self.setMinimumSize(600, 450)

        # Motor VLC
        self.vlc_instance = vlc.Instance("--no-video")
        self.player = self.vlc_instance.media_player_new()

        self.current_song = None
        self.worker = None
        self.seeking = False

        self.init_ui()
        self.apply_styles()

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_progress)
        self.timer.start(500)

    # -----------------------------------------
    # INTERFAZ
    # -----------------------------------------

    def init_ui(self):

        central = QWidget()
        self.setCentralWidget(central)

        layout = QVBoxLayout(central)
        layout.setContentsMargins(25, 25, 25, 25)
        layout.setSpacing(20)

        title = QLabel("♫  Reproductor")
        title.setObjectName("title")
        layout.addWidget(title)

        # Buscador de URL
        self.url_input = QLineEdit()
        self.url_input.setPlaceholderText(
            "Introduce la URL de una fuente de audio..."
        )

        self.search_button = QPushButton("Buscar y reproducir")
        self.search_button.clicked.connect(self.search_audio)

        search_layout = QHBoxLayout()
        search_layout.addWidget(self.url_input, 1)
        search_layout.addWidget(self.search_button)

        layout.addLayout(search_layout)

        # Información de canción
        self.song_title = QLabel("Ninguna canción seleccionada")
        self.song_title.setObjectName("songTitle")
        self.song_title.setAlignment(Qt.AlignmentFlag.AlignCenter)

        self.song_duration = QLabel("Duración: --:--")
        self.song_duration.setObjectName("songArtist")
        self.song_duration.setAlignment(Qt.AlignmentFlag.AlignCenter)

        layout.addSpacing(15)
        layout.addWidget(self.song_title)
        layout.addWidget(self.song_duration)

        # Controles
        controls = QHBoxLayout()
        controls.setAlignment(Qt.AlignmentFlag.AlignCenter)
        controls.setSpacing(25)

        self.previous_button = QPushButton("⏮")
        self.previous_button.setObjectName("secondaryButton")
        self.previous_button.setEnabled(False)

        self.play_button = QPushButton("▶")
        self.play_button.setObjectName("playButton")
        self.play_button.clicked.connect(self.toggle_play)

        self.next_button = QPushButton("⏭")
        self.next_button.setObjectName("secondaryButton")
        self.next_button.setEnabled(False)

        controls.addWidget(self.previous_button)
        controls.addWidget(self.play_button)
        controls.addWidget(self.next_button)

        layout.addLayout(controls)

        # Progreso
        progress_layout = QHBoxLayout()

        self.current_time = QLabel("00:00")
        self.total_time = QLabel("00:00")

        self.progress = QSlider(Qt.Orientation.Horizontal)
        self.progress.setRange(0, 1000)

        self.progress.sliderPressed.connect(
            lambda: setattr(self, "seeking", True)
        )

        self.progress.sliderReleased.connect(
            self.seek_audio
        )

        progress_layout.addWidget(self.current_time)
        progress_layout.addWidget(self.progress, 1)
        progress_layout.addWidget(self.total_time)

        layout.addLayout(progress_layout)

        # Estado
        self.status = QLabel("Introduce una URL para comenzar.")
        self.status.setObjectName("status")
        self.status.setAlignment(Qt.AlignmentFlag.AlignCenter)

        layout.addStretch()
        layout.addWidget(self.status)

    # -----------------------------------------
    # CONSULTA DE FUENTE
    # -----------------------------------------

    def search_audio(self):

        url = self.url_input.text().strip()

        if not url:
            self.status.setText("Introduce una URL.")
            return

        if self.worker and self.worker.isRunning():
            self.status.setText(
                "Espera a que termine la consulta actual."
            )
            return

        if not urlparse(url).scheme or not urlparse(url).netloc:
            self.status.setText("La URL no es válida.")
            return

        self.search_button.setEnabled(False)
        self.status.setText("Consultando información de la fuente...")

        self.worker = ExtractorWorker(url)

        self.worker.success.connect(self.audio_ready)
        self.worker.error.connect(self.extraction_error)

        self.worker.start()

    def audio_ready(self, info):

        self.search_button.setEnabled(True)

        self.current_song = info

        self.song_title.setText(info["title"])

        duration = info["duration"]

        self.song_duration.setText(
            f"Duración: {self.format_time(duration * 1000)}"
            if duration else "Duración desconocida"
        )

        self.play_stream(info)

    def extraction_error(self, message):

        self.search_button.setEnabled(True)
        self.status.setText("No se pudo obtener el audio.")

        QMessageBox.warning(
            self,
            "Error de reproducción",
            message
        )

    # -----------------------------------------
    # VLC
    # -----------------------------------------

    def play_stream(self, info):

        self.player.stop()

        media = self.vlc_instance.media_new(info["url"])

        # Encabezados HTTP proporcionados por yt-dlp.
        headers = info.get("headers", {})

        for name, value in headers.items():

            if name.lower() in (
                "user-agent",
                "referer",
                "authorization"
            ):
                media.add_option(
                    f":http-{name.lower()}={value}"
                )

        self.player.set_media(media)
        self.player.play()

        self.play_button.setText("⏸")
        self.status.setText("Reproduciendo audio...")

    def toggle_play(self):

        if not self.current_song:
            return

        state = self.player.get_state()

        if state == vlc.State.Playing:
            self.player.pause()
            self.play_button.setText("▶")

        elif state in (
            vlc.State.Paused,
            vlc.State.Stopped,
            vlc.State.NothingSpecial
        ):
            self.player.play()
            self.play_button.setText("⏸")

    # -----------------------------------------
    # PROGRESO
    # -----------------------------------------

    def update_progress(self):

        if not self.current_song:
            return

        current = self.player.get_time()
        total = self.player.get_length()

        if current < 0 or total <= 0:
            return

        self.current_time.setText(
            self.format_time(current)
        )

        self.total_time.setText(
            self.format_time(total)
        )

        if not self.seeking:

            self.progress.setValue(
                int((current / total) * 1000)
            )

        state = self.player.get_state()

        if state == vlc.State.Ended:
            self.play_button.setText("▶")

        elif state == vlc.State.Playing:
            self.play_button.setText("⏸")

        elif state == vlc.State.Paused:
            self.play_button.setText("▶")

    def seek_audio(self):

        total = self.player.get_length()

        if total > 0:

            position = self.progress.value() / 1000

            self.player.set_time(
                int(position * total)
            )

        self.seeking = False

    @staticmethod
    def format_time(milliseconds):

        seconds = max(0, milliseconds // 1000)

        return f"{seconds // 60:02d}:{seconds % 60:02d}"

    # -----------------------------------------
    # ESTILOS
    # -----------------------------------------

    def apply_styles(self):

        self.setStyleSheet("""
            QMainWindow {
                background-color: #101522;
            }

            QWidget {
                color: #f2f4fa;
                font-family: "Segoe UI";
                font-size: 14px;
            }

            QLabel#title {
                font-size: 23px;
                font-weight: bold;
            }

            QLabel#songTitle {
                font-size: 21px;
                font-weight: bold;
            }

            QLabel#songArtist,
            QLabel#status {
                color: #9ba6bd;
            }

            QPushButton {
                background-color: #263148;
                border: none;
                border-radius: 8px;
                padding: 10px 15px;
            }

            QPushButton:hover {
                background-color: #354665;
            }

            QPushButton:disabled {
                color: #657086;
            }

            QPushButton#playButton {
                background-color: #287cf0;
                border-radius: 35px;
                min-width: 45px;
                min-height: 45px;
                font-size: 22px;
            }

            QPushButton#secondaryButton {
                border-radius: 25px;
                min-width: 35px;
                min-height: 35px;
                font-size: 19px;
            }

            QLineEdit {
                background-color: #1b2435;
                border: 1px solid #35415a;
                border-radius: 7px;
                padding: 10px;
            }

            QSlider::groove:horizontal {
                background: #35415a;
                height: 5px;
                border-radius: 2px;
            }

            QSlider::sub-page:horizontal {
                background: #287cf0;
            }

            QSlider::handle:horizontal {
                background: #287cf0;
                width: 13px;
                margin: -5px 0;
                border-radius: 6px;
            }
        """)

    # -----------------------------------------
    # CIERRE
    # -----------------------------------------

    def closeEvent(self, event):

        self.timer.stop()
        self.player.stop()

        if self.worker and self.worker.isRunning():
            self.worker.quit()
            self.worker.wait(3000)

        self.player.release()
        self.vlc_instance.release()

        event.accept()


if __name__ == "__main__":

    app = QApplication(sys.argv)

    window = Reproductor()
    window.show()

    sys.exit(app.exec())
