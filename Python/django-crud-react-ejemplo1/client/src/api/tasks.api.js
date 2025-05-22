// Se encarga de hacer la peticion a la api

import axios from 'axios';

export const getAllTasks = () => {
    return axios.get("http://127.0.0.1:8000/task/api/v1/tasks/");
}