{/* Lista las tareas */}

import { useEffect, useState } from "react";
import { getAllTasks } from "../api/tasks.api";
import { TaskCard } from "./TaskCard";

export function TasksList() {

    {/* Peticion al backend para las tareas */}
    const [tasks, setTasks] = useState([]);

    useEffect(() => {
        
        {/* Funcion asincrona para ejecutar la funcion de la llamada  a la api */}
        async function loadTasks() {
            const res = await getAllTasks();
            setTasks(res.data); {/* Obteniendo solo las tareas de la respuesta obtenida */}
        }
        loadTasks();


    }, []);

    return (
        <div>
            {tasks.map(task => (
                <TaskCard key={task.id} task={task} />  // Componente para mostrar cada tarea
            ))}
        </div>
    );
}