package com.example.spring_batch_ejemplo.configuration;

import com.example.spring_batch_ejemplo.model.Cuenta;
import com.example.spring_batch_ejemplo.processor.CuentaItemProcessor;
import com.example.spring_batch_ejemplo.writer.ReportWriter;
import jakarta.persistence.EntityManagerFactory;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.file.FlatFileItemReader;
import org.springframework.batch.item.file.builder.FlatFileItemReaderBuilder;
import org.springframework.batch.item.file.mapping.BeanWrapperFieldSetMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
public class BatchConfig {

    private final EntityManagerFactory emf;

    public BatchConfig(EntityManagerFactory emf) {
        this.emf = emf;
    }

    @Bean
    public FlatFileItemReader<Cuenta> reader() {
        return new FlatFileItemReaderBuilder<Cuenta>()
                .name("cuentaItemReader")
                .resource(new ClassPathResource("cuentas.csv"))
                .delimited()
                .names("id","cuenta","estatus")
                .fieldSetMapper(new BeanWrapperFieldSetMapper<>() {{
                    setTargetType(Cuenta.class);
                }})
                .linesToSkip(1)
                .build();
    }

    @Bean
    public CuentaItemProcessor processor() {
        return new CuentaItemProcessor();
    }

    @Bean
    public ReportWriter writer() {
        return new ReportWriter((emf));
    }

    @Bean
    public Step step(JobRepository jobRepository, PlatformTransactionManager transactionManager) {
        return new StepBuilder("step1", jobRepository)
                .<Cuenta, Cuenta>chunk(4, transactionManager)
                .reader(reader())
                .processor(processor())
                .writer(writer())
                .build();
    }

    public Job job(JobRepository jobRepository, Step step) {
        return new JobBuilder("importarCuentasJob", jobRepository)
                .incrementer(new RunIdIncrementer())
                .start(step)
                .build();
    }
}
