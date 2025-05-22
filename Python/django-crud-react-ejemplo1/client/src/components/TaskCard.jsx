{/* Componente que construye la vista de cada tarea para mostrarla,
    recibe como parametro la tarea como parametro*/}

export function TaskCard({ task }) {
    return (
        <div>
            <h1>{task.title}</h1>
            <p>{task.description}</p>
            <hr />
        </div>
    );
}