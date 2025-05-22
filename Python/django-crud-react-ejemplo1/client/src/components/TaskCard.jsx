{/* Componente que construye la vista de cada tarea para mostrarla,
    recibe como parametro la tarea como parametro*/}

import { useNavigate } from 'react-router-dom';

export function TaskCard({ task }) {

    const navigate = useNavigate();

    return (
        <div 
            onClick={() => {
                navigate(`/tasks/${task.id}`)
            }}
        >
            <h1>{task.title}</h1>
            <p>{task.description}</p>
            <hr />
        </div>
    );
}