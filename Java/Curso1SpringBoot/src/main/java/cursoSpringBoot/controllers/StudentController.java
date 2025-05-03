package cursoSpringBoot.controllers;

import cursoSpringBoot.domain.Student;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/students")
public class StudentController {

    // Datos prueba para este ejemplo
    private List<Student> studentList = new ArrayList<>(Arrays.asList(
            new Student("Julian", "Alvarez", "alva-jul@correo", 20, "curso1", 0),
            new Student("Pedro", "Hernandez", "ped-hz@correo", 22, "curso1", 1),
            new Student("Sebastian", "Ortiz", "seb-or@correo", 21, "curso1", 2),
            new Student("Eduardo", "Perez", "ed-per@correo", 21, "curso1", 3)
    ));

    @GetMapping
    public List<Student> getStudents() {
        return studentList;
    }

    @GetMapping("/{id}")
    public Student getStudent(@PathVariable int id) {
        for(Student s: studentList) {
            if(s.getId()==id) {
                return s;
            }
        }
        return null; // No debe regresar null, se ajustara despues
    }

    @PostMapping
    public Student postStudent(@RequestBody Student student) {
        studentList.add(student);
        return student;
    }

    @PutMapping()
    public Student putStudent(@RequestBody Student student) {
        for(Student s: studentList) {
            if(s.getId()==student.getId()) {
                s.setNombre(student.getNombre());
                s.setApellido_p((student.getApellido_p()));
                s.setEdad(student.getEdad());
                s.setEmail(student.getEmail());
                s.setCurso(student.getCurso());
                return s;
            }
        }
        return null; // No debe regresar null, se ajustara despues
    }

    @PatchMapping()
    public Student patchStudent(@RequestBody Student student) {
        for(Student s: studentList) {
            if(s.getId()==student.getId()) {
                if (student.getNombre()!=null) {
                    s.setNombre(student.getNombre());
                }
                if (student.getApellido_p()!=null) {
                    s.setApellido_p((student.getApellido_p()));
                }
                if (student.getEdad()!= 0) {
                    s.setEdad(student.getEdad());
                }
                if (student.getEmail()!=null) {
                    s.setEmail(student.getEmail());
                }
                if (student.getCurso()!=null) {
                    s.setCurso(student.getCurso());
                }
                return s;
            }
        }
        return null; // No debe regresar null, se ajustara despues
    }

    @DeleteMapping("/{id}")
    public Student deleteStudent(@PathVariable int id) {
        for(Student s: studentList) {
            if(s.getId()==id) {
                studentList.remove(s);
                return s;
            }
        }
        return null; // No debe regresar null, se ajustara despues
    }
}
