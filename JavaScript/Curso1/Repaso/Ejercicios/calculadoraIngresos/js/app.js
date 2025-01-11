const ingresos = [
    new Ingreso("Salario",20000.00),
    new Ingreso("Venta computadora",8500.00),
    new Ingreso("Bono",2500.00)
];

const egresos = [
    new Egreso("Renta departamento",1200.00),
    new Egreso("Musica", 200.00)
]

let cargarApp = ()=> {
    cargarCabecero();
    cargarIngresos();
    cargarEgresos();
}

let totalIngresos = ()=> {
    let totalIngreso = 0;
    for(let ingreso of ingresos) {
        totalIngreso += ingreso.valor;
    }
    return totalIngreso;
}

let totalEgresos = ()=> {
    let totalEgreso = 0;
    for(let egreso of egresos) {
        totalEgreso += egreso.valor;
    }
    return totalEgreso;
}

let cargarCabecero = ()=> {
    let presupuesto = totalIngresos()-totalEgresos();
    let porcentajeEgreso = totalEgresos()/totalIngresos();
    document.getElementById("presupuesto").innerHTML = formatoMoneda(presupuesto);
    document.getElementById("porcentaje").innerHTML = formatoPorcentaje(porcentajeEgreso);
    document.getElementById("ingresos").innerHTML = formatoMoneda(totalIngresos());
    document.getElementById("egresos").innerHTML = formatoMoneda(totalEgresos());
}

// Darle formato a los valores 
const formatoMoneda = (valor) => {
    return valor.toLocaleString("en-US", {style:"currency", currency:"USD", minimunFractionDigits:2});
}

const formatoPorcentaje = (valor)=> {
    return valor.toLocaleString("en-US",{style:"percent",minimunFractionDigits:2});
}

// Funciones para egresos e ingresos
const cargarIngresos = ()=> {
    let ingresosHTML = "";
    for(let ingreso of ingresos) {
        ingresosHTML += crearIngresoHTML(ingreso);
    }
    document.getElementById("lista-ingresos").innerHTML = ingresosHTML;
}

const crearIngresoHTML = (ingreso)=> {
    let ingresoHTML = `
        <div class="elemento limpiarEstilos">
                    <div class="elemento_descripcion">${ingreso.descripcion}</div>
                    <div class="derecha limpiarEstilos">
                        <div class="elemento_valor">+ ${formatoMoneda(ingreso.valor)}</div>
                        <div class="elemento_eliminar">
                            <button class="elemento_eliminar--btn">
                                <ion-icon name="close-circle-outline"
                                    onclick="eliminarIngreso(${ingreso.id})"></ion-icon>
                            </button>
                        </div>
                    </div>
                </div>
    `;
    return ingresoHTML;
}

const eliminarIngreso = (id)=> {
    let indiceEliminar = ingresos.findIndex(ingreso=> ingreso.id===id); // Encontrar el elemento
    ingresos.splice(indiceEliminar,1);
    cargarCabecero();
    cargarIngresos();
}

const cargarEgresos = ()=> {
    let egresosHTML = "";
    for(let egreso of egresos) {
        egresosHTML += crearEgresosHTML(egreso);
    }
    document.getElementById("lista-egresos").innerHTML = egresosHTML;
}

const crearEgresosHTML = (egreso)=> {
    let egresoHTML = `
        <div class="elemento limpiarEstilos">
                    <div class="elemento_descripcion">${egreso.descripcion}</div>
                    <div class="derecha limpiarEstilos">
                        <div class="elemento_valor">- ${formatoMoneda(egreso.valor)}</div>
                        <div class="elemento_porcentaje">${formatoPorcentaje(egreso.valor/totalEgresos())}</div>
                        <div class="elemento_eliminar">
                            <button class="elemento_eliminar--btn">
                                <ion-icon name="close-circle-outline"
                                    onclick="eliminarEgreso(${egreso.id})"></ion-icon>
                            </button>
                        </div>
                    </div>
                </div>
    `;
    return egresoHTML;
}

const eliminarEgreso = (id)=> {
    let indiceEliminar = egresos.findIndex(egreso=> egreso.id===id); // Encontrar el elemento
    egresos.splice(indiceEliminar,1);
    cargarCabecero();
    cargarEgresos();
}

let agregarDato = ()=> {
    let formulario = document.forms["formulario"];
    let tipo = formulario["tipo"];
    let descripcion = formulario["descripcion"];
    let valor = formulario["valor"];
    if(descripcion.value!=="" && valor.value!=="") {
        if(tipo.value === "ingreso") {
            ingresos.push(new Ingreso(descripcion.value, Number(valor.value)));
            cargarCabecero();
            cargarIngresos();
        } else if(tipo.value === "egreso") {
            egresos.push(new Egreso(descripcion.value, Number(valor.value)));
            cargarCabecero();
            cargarEgresos();
        }
    } else {
        alert("El campo 'Descripcion' o 'Valor' no es valido.");
        return;
    }
}