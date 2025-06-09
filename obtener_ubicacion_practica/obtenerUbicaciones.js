const options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0,
};

function success(pos) {
    const crd = pos.coords;
    const lon = crd.longitude;
    const lat = crd.latitude;
    document.getElementById("mi_ubicacion").innerText = `Latitud: ${lat}, longitud: ${lon}`;
}

function error(err) {
    document.getElementById("mi_ubicacion").innerText = "Error al obtener la ubicacion, posiblemente el navegador no es compatible.";
    console.warn(`ERROR(${err.code}): ${err.message}`);
}

function getMyLocation() {
    if (navigator.geolocation) {
        document.getElementById("mi_ubicacion").innerText = "Obteniendo ubicacion...";
        navigator.geolocation.getCurrentPosition(success, error, options);
    }
}

function getLocation() {

}