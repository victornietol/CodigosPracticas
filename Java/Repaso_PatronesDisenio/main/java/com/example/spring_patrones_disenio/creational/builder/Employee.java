package com.example.spring_patrones_disenio.creational.builder;

import java.time.LocalDate;

public class Employee {

    private Long id;
    private String username;
    private String email;
    private Double salary;
    private Boolean married;
    private Integer age;
    private LocalDate birthDate;
    private Integer workYears;

    public Employee(Long id, String username, String email, Double salary, Boolean married, Integer age, LocalDate birthDate, Integer workYears) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.salary = salary;
        this.married = married;
        this.age = age;
        this.birthDate = birthDate;
        this.workYears = workYears;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Double getSalary() {
        return salary;
    }

    public void setSalary(Double salary) {
        this.salary = salary;
    }

    public Boolean getMarried() {
        return married;
    }

    public void setMarried(Boolean married) {
        this.married = married;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public Integer getWorkYears() {
        return workYears;
    }

    public void setWorkYears(Integer workYears) {
        this.workYears = workYears;
    }

    public static final class Builder{
        private Long id;
        private String username;
        private String email;
        private Double salary;
        private Boolean married;
        private Integer age;
        private LocalDate birthDate;
        private Integer workYears;

        Employee build() {
            return new Employee(this.id, this.username, this.email, this.salary, this.married, this.age, this.birthDate, this.workYears);
        }

        public Long getId() {
            return id;
        }

        public String getUsername() {
            return username;
        }

        public String getEmail() {
            return email;
        }

        public Double getSalary() {
            return salary;
        }

        public Boolean getMarried() {
            return married;
        }

        public Integer getAge() {
            return age;
        }

        public LocalDate getBirthDate() {
            return birthDate;
        }

        public Integer getWorkYears() {
            return workYears;
        }

        public Builder setId(Long id) {
            this.id = id;
            return this;
        }

        public Builder setUsername(String username) {
            this.username = username;
            return this;
        }

        public Builder setEmail(String email) {
            this.email = email;
            return this;
        }

        public Builder setSalary(Double salary) {
            this.salary = salary;
            return this;
        }

        public Builder setMarried(Boolean married) {
            this.married = married;
            return this;
        }

        public Builder setAge(Integer age) {
            this.age = age;
            return this;
        }

        public Builder setBirthDate(LocalDate birthDate) {
            this.birthDate = birthDate;
            return this;
        }

        public Builder setWorkYears(Integer workYears) {
            this.workYears = workYears;
            return this;
        }
    }
}
