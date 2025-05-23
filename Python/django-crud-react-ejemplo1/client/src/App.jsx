import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import { TasksPage } from './pages/TasksPage';
import { TasksFormPage } from './pages/TaskFormPage';
import { Navigation } from './components/Navigation';
import { Toaster } from 'react-hot-toast'; // Noticaciones al realizar cambios 

function App() {
  return (
    <BrowserRouter>
      <div className="container mx-auto">
        <Navigation />

        <Routes>
          <Route path="/" element={<Navigate to="/tasks" />} /> {/* Indica a que ruta se redirecciona al visitar el inicio, esto es opcional dependiendo del proyecto */}
          <Route path="/tasks" element={<TasksPage />} />
          <Route path="/tasks-create" element={<TasksFormPage />} />
          <Route path="/tasks/:id" element={<TasksFormPage />} />
        </Routes>

        <Toaster />
      </div>

    </BrowserRouter>
  );
}

export default App;