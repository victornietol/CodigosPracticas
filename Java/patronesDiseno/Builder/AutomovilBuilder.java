package org.example.patronesDiseno.Builder;

public class AutomovilBuilder {
    // valores por defecto
    private String arg1;
    private String arg2;
    private String arg3;
    private String arg4;
    private String arg5;
    private String arg6;

    // Constructor privado que recibe al Builder
    private AutomovilBuilder(BuilderInst builder) {
        this.arg1 = builder.arg1;
        this.arg2 = builder.arg2;
        this.arg3 = builder.arg3;
        this.arg4 = builder.arg4;
        this.arg5 = builder.arg5;
        this.arg6 = builder.arg6;
    }

    // Clase Builder para asignar los argumentos
    public static class BuilderInst {
        // Tienen los mismos arguentos que la clase superior
        private String arg1;
        private String arg2;
        private String arg3;
        private String arg4;
        private String arg5;
        private String arg6;

        // Tiene los setters

        public BuilderInst setArg1(String arg1) {
            this.arg1 = arg1;
            return this;
        }

        public BuilderInst setArg2(String arg2) {
            this.arg2 = arg2;
            return this;
        }

        public BuilderInst setArg3(String arg3) {
            this.arg3 = arg3;
            return this;
        }

        public BuilderInst setArg4(String arg4) {
            this.arg4 = arg4;
            return this;
        }

        public BuilderInst setArg5(String arg5) {
            this.arg5 = arg5;
            return this;
        }

        public BuilderInst setArg6(String arg6) {
            this.arg6 = arg6;
            return this;
        }

        //Metodo para construir la instancia final (con este se crea el objeto)
        public AutomovilBuilder build() {
            return new AutomovilBuilder(this);
        }

        // Se pueden agregar setter tambien ...
    }
}
