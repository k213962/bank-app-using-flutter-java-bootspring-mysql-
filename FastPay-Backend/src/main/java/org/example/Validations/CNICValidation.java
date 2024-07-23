package org.example.Validations;


import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.example.Validations.Annotations.CNICValidator;

public class CNICValidation implements ConstraintValidator<CNICValidator,String> {

    @Override
    public void initialize(CNICValidator CNIC) {
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {

        // Implement your validation logic here
        // Return true if validation passes, false otherwise
        System.out.println(value);
        return value != null && value.matches("^[0-9+]{5}-[0-9+]{7}-[0-9]{1}$");  // Example validation condition
    }



}
