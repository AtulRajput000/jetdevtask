//
//  LoginValidation.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation

struct LoginValidation {

    func validate(loginRequest: LoginRequest) -> ValidationResult {
        let lEmail = (loginRequest.email ?? "")
        if lEmail.isEmpty == true {
            return ValidationResult(success: false, error: "Email is empty")
        }
        if lEmail.isEmpty == false,
           lEmail.isValidEmail() == false {
            return ValidationResult(success: false, error: "Email is not valid")
        }
        
        let lPassword = (loginRequest.password ?? "")
        if lPassword.isEmpty == true {
            return ValidationResult(success: false, error: "Password is empty")
        }

        return ValidationResult(success: true, error: nil)
    }

}
