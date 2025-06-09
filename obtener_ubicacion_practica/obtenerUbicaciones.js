const options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0,
};

function success(pos) {
    const crd = pos.coords;
    const myLon = crd.longitude;
    const myLat = crd.latitude;
    document.getElementById("mi_ubicacion").innerText = `Latitud: ${myLat}, longitud: ${myLon}`;
}

function error(err) {
    document.getElementById("mi_ubicacion").innerText = "Error al obtener la ubicacion, posiblemente el navegador no es compatible.";
    console.warn(`ERROR(${err.code}): ${err.message}`);
}

function getMyLocation() {
    return new Promise((resolve) => {
        if (!navigator.geolocation) {
            resolve(null);
        }
        navigator.geolocation.getCurrentPosition(
            pos => { // Misma funcion que 'sucess', pero ahora puedo regresar un valor
                const crd = pos.coords;
                const myLon = crd.longitude;
                const myLat = crd.latitude;
                resolve([myLon, myLat]);
            },
            error, 
            options
        );
    });

    /*
    if (navigator.geolocation) {
        document.getElementById("mi_ubicacion").innerText = "Obteniendo ubicacion...";
        navigator.geolocation.getCurrentPosition(success, error, options);
    }*/
}

async function showMyLocation() {
    document.getElementById("mi_ubicacion").innerText = "Obteniendo ubicacion...";
    const [myLon, myLat] = await getMyLocation();
    document.getElementById("mi_ubicacion").innerText = `Latitud: ${myLat}, longitud: ${myLon}`;
}

function getLocation() {
    const location = document.getElementById("buscar_ubicacion").value;
    const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(location)}`;

    fetch(url)
        .then(res => res.json())
        .then(data => {
            if (data.length > 0) {
                const lat = data[0].lat;
                const lon = data[0].lon;
                document.getElementById("latitud").innerText = `${lat}`;
                document.getElementById("longitud").innerText = `${lon}`;
            } else {
                document.getElementById("latitud").innerText = "Sin informacion disponible";
                document.getElementById("longitud").innerText = "Sin informacion disponible";
            }
        })
        .catch(() => {
            document.getElementById("latitud").innerText = "Error en la solicitud";
            document.getElementById("longitud").innerText = "Error en la solicitud";
        });
}

async function compareLocation() {
    const [myLon, myLat] = await getMyLocation();
}