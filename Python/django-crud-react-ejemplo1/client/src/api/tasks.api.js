// Se encarga de hacer peticiones a la api

import axios from 'axios';

// Asignar la ruta para las peticiones
const tasksApi = axios.create({
    baseURL: "http://127.0.0.1:8000/task/api/v1/tasks/"
})

// Obtener todos los datos
export const getAllTasks = () => tasksApi.get("/");

// Obtener un solo elemento
export const getTask = (id) => tasksApi.get(`/${id}/`);

// Enviar datos
export const createTask = (task) => tasksApi.post("/", task);

// Eliminar datos (por su id)
export const deleteTask = (id) => tasksApi.delete(`/${id}`);

// Actualizar datos
export const updateTask = (id, task) => tasksApi.put(`/${id}/`, task)