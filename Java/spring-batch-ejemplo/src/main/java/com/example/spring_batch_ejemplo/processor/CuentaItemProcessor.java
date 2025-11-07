package com.example.spring_batch_ejemplo.processor;

import com.example.spring_batch_ejemplo.model.Cuenta;
import org.springframework.batch.item.ItemProcessor;

public class CuentaItemProcessor implements ItemProcessor<Cuenta, Cuenta> {


    @Override
    public Cuenta process(Cuenta cuenta) throws Exception {
        if("R".equalsIgnoreCase(cuenta.getEstatus()))
            return cuenta;
        return null;
    }
}
