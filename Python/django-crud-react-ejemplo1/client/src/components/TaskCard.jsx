{/* Componente que construye la vista de cada tarea para mostrarla,
    recibe como parametro la tarea como parametro*/}

import { useNavigate } from 'react-router-dom';

export function TaskCard({ task }) {

    const navigate = useNavigate();

    return (
        <div 
            className='bg-zinc-800 p-3 hover:bg-zinc-700 hover:cursor-pointer'
            onClick={() => {
                navigate(`/tasks/${task.id}`)
            }}
        >
            <h1 className='font-bold uppercase'>{task.title}</h1>
            <p className='text-slate-400'>{task.description}</p>
        </div>
    );
}