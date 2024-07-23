package org.example.Generator;

import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.id.IdentifierGenerator;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.io.Serializable;







public class AccountSequenceGenerator implements IdentifierGenerator {

    private static long sequence = 1;

    @Override
    public Serializable generate(SharedSessionContractImplementor session, Object object)
            throws HibernateException {
        // You can implement your custom logic to generate the sequence here
        long generatedValue = getNextValue();
        return "ACC-FASTPay00" + generatedValue;
    }

    private synchronized long getNextValue() {
        return sequence++;
    }
}