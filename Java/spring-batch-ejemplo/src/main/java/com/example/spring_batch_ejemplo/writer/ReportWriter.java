package com.example.spring_batch_ejemplo.writer;

import com.example.spring_batch_ejemplo.model.Cuenta;
import jakarta.persistence.EntityManagerFactory;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.AfterStep;
import org.springframework.batch.item.database.JpaItemWriter;

import java.io.FileWriter;
import java.io.IOException;

public class ReportWriter extends JpaItemWriter<Cuenta> {

    public ReportWriter(EntityManagerFactory emf) {
        super.setEntityManagerFactory(emf);
    }

    @AfterStep
    public void afterStep(StepExecution stepExecution) {
        int leidos = (int) stepExecution.getReadCount();
        int escritos = (int) stepExecution.getWriteCount();
        int ignorados = leidos - escritos;

        try (FileWriter writer = new FileWriter("report.txt")) {
            writer.write("Total leidos="+ leidos+ "\n");
            writer.write("Total guardados="+ escritos+ "\n");
            writer.write("Total ignorados="+ ignorados+ "\n");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
