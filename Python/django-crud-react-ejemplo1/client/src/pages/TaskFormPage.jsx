import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { createTask, deleteTask, updateTask, getTask } from '../api/tasks.api';
import { useNavigate, useParams } from 'react-router-dom';
import { toast } from 'react-hot-toast';

export function TasksFormPage() {

    const { 
        register, 
        handleSubmit, 
        formState: { errors },
        setValue // Permiite colocar valores al formulario
    } = useForm(); {/* Manejar formulario (registra campos y hacer validaciones) */}
    const navigate = useNavigate(); {/* Navegador para indicar que hacer al guardar los datos */}
    const params = useParams();  // Obtener parametros de la url (id en este caso)

    const onSubmit = handleSubmit(async data => { // Funcion para guardar los datos introducidos en el formulario
        if (params.id) {
            // Actualizando
            await updateTask(params.id, data);
            toast.success( "Tarea actualizada", {  // Notificacon de cambio
                position: "bottom-right",
                style: {
                    background: "#101010",
                    color: "#fff"
                }
            });
        } else {
            // Creando
            await createTask(data);
            toast.success( "Tarea creada", {  // Notificacon de cambio
                position: "bottom-right",
                style: {
                    background: "#101010",
                    color: "#fff"
                }
            });
        }
        navigate("/tasks");
    });

    useEffect(() => {
        async function loadTask() { // Como es una funcion asincrona, no puede ir directamente dentro de useEffect, sino que debe colocarse en otra funcion
            if(params.id) {
                const response = await getTask(params.id);
                setValue("title", response.data.title);
                setValue("description", response.data.description);
            }
        }
        loadTask();
    });

    return (
        <div className='max-w-xl mx-auto'>
            <form onSubmit={onSubmit}>
                <input 
                    type="text" 
                    placeholder="title" 
                    {...register("title", { required: true })}
                    className='bg-zinc-700 p-3 rounded-lg block w-full mb-3'
                />
                {errors.title && <span>El titulo es requerido</span>}

                <textarea 
                    rows="3" 
                    placeholder="description" 
                    {...register("description", { required:true })}
                    className='bg-zinc-700 p-3 rounded-lg block w-full mb-3'
                ></textarea>
                {errors.description && <span>La descripcion es requerida</span>}

                <button className='bg-indigo-500 p-3 rounded-lg block w-full mt-3'>
                    Guardar
                </button>
            </form>

            {params.id && (
                <div className='flex justify-end'>
                    <button 
                        className='bg-red-500 p-3 rounded-lg w-48 mt-3'
                        onClick={async () => {
                            const confirm = window.confirm("¿Estas seguro?");
                            if (confirm) {
                                await deleteTask(params.id);
                                toast.success( "Tarea eliminada", {  // Notificacon de cambio
                                    position: "bottom-right",
                                    style: {
                                        background: "#101010",
                                        color: "#fff"
                                    }
                                });
                                navigate("/tasks");
                            }
                        }} 
                    >
                        Eliminar
                    </button>
                </div>
            )}
        </div>
    );
}