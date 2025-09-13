package org.example.patronesDiseno.ResultPattern;

public class Result<T> {

    public boolean isSuccess;
    public boolean isFailure;
    public String error;
    public T value;

    protected Result(T value, boolean isSuccess, String error) {
        this.isSuccess = isSuccess;
        this.isFailure = !this.isSuccess;
        this.error = error;
        this.value = value;
    }

    public static <T> Result<T> success(T value) {
        return new Result<T>(value, true, "");
    }

    public static <T> Result<T> failure(String error) {
        return new Result<T>(null, false, error);
    }
}
