// Se encarga de hacer peticiones a la api

import axios from 'axios';

// Asignar la ruta para las peticiones
const tasksApi = axios.create({
    baseURL: "http://127.0.0.1:8000/task/api/v1/tasks/"
})

// Obtener datos
export const getAllTasks = () => tasksApi.get("/");

// Enviar datos
export const createTask = (task) => tasksApi.post("/", task);

// Eliminar datos (por su id)
export const deleteTask = (id) => tasksApi.delete(`/${id}`);