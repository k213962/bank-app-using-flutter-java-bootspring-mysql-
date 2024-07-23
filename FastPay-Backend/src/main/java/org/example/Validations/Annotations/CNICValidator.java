package org.example.Validations.Annotations;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.example.Validations.CNICValidation;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = CNICValidation.class)
@Target( { ElementType.METHOD, ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface CNICValidator {
    String message() default "Invalid CNIC number";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
