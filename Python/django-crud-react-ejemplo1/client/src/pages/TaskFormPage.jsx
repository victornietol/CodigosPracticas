import { useForm } from 'react-hook-form';
import { createTask, deleteTask } from '../api/tasks.api';
import { useNavigate, useParams } from 'react-router-dom';

export function TasksFormPage() {

    const { register, handleSubmit, formState: { errors } } = useForm(); {/* Manejar formulario (registra campos y hacer validaciones) */}
    const navigate = useNavigate(); {/* Navegador para indicar que hacer al guardar los datos */}
    const params = useParams();  // Obtener parametros de la url (id en este caso)

    const onSubmit = handleSubmit(async data => { // Funcion para guardar los datos introducidos en el formulario
        await createTask(data);
        navigate("/tasks");
    });

    return (
        <div>
            <form onSubmit={onSubmit}>
                <input 
                    type="text" 
                    placeholder="title" 
                    {...register("title", { required: true })}
                />
                {errors.title && <span>El titulo es requerido</span>}

                <textarea 
                    rows="3" 
                    placeholder="description" 
                    {...register("description", { required:true })}
                />
                {errors.description && <span>La descripcion es requerida</span>}

                <button>Guardar</button>
            </form>

            {params.id && <button onClick={async () => {
                const confirm = window.confirm("¿Estas seguro?");
                if (confirm) {
                    await deleteTask(params.id);
                    navigate("/tasks")
                }
            }} >Eliminar</button>}
        </div>
    );
}