function toRad(degrees) {
    return degrees * Math.PI/180;
}

// Funcion para obtener la distancia entre dos ubicaciones
function haversineDist(lat1, lon1, lat2, lon2) {
    const R = 6371; // Radio deL planeta en km
    const dLat = toRad(lat2 - lat1);
    const dLon = toRad(lon2 - lon1);
    const lat1Rad = toRad(lat1);
    const lat2Rad = toRad(lat2);
    const a = Math.sin(dLat/2) ** 2 +
              Math.cos(lat1Rad) * Math.cos(lat2Rad) *
              Math.sin(dLon/2) ** 2;
    const c = 2*Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    return R*c; // distancia en km
}

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
                resolve({lon: myLon, lat: myLat});
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
    const location = await getMyLocation();
    document.getElementById("mi_ubicacion").innerText = `Latitud: ${location.lat}, longitud: ${location.lon}`;
}

async function getLocation(location) {
    const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(location)}`;

     try {
        const res = await fetch(url);
        const data = await res.json();

        if (data.length > 0) {
            return { lat: data[0].lat, lon: data[0].lon };
        } else {
            return { lat: "Sin información", lon: "Sin información" };
        }
    } catch (error) {
        return { lat: "Error en la solicitud", lon: "Error en la solicitud" };
    }
}

async function showLocation() {
    document.getElementById("latitud").innerText = "Buscando...";
    document.getElementById("longitud").innerText = "Buscando...";
    const location = document.getElementById("buscar_ubicacion").value;

    const res = await getLocation(location);
    document.getElementById("latitud").innerText = `${res.lat}`;
    document.getElementById("longitud").innerText = `${res.lon}`;
}

async function compareLocation() {
    document.getElementById("resultado_comparacion").innerText = "Obteniendo...";
    const myLocation = await getMyLocation();

    const value1 = document.getElementById("comparar_ubicacion_1").value;
    const value2 = document.getElementById("comparar_ubicacion_2").value;
    const location1 = await getLocation(value1);
    const location2 = await getLocation(value2);
    
    const dist1 = haversineDist(myLocation.lat, myLocation.lon, location1.lat, location1.lon);
    const dist2 = haversineDist(myLocation.lat, myLocation.lon, location2.lat, location2.lon);

    if (dist1<dist2) {
        document.getElementById("resultado_comparacion").innerText = `${value1}`;
    } else {
        document.getElementById("resultado_comparacion").innerText = `${value2}`;
    }
}