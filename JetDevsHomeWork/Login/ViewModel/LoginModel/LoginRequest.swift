//
//  LoginRequest.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation

struct LoginRequest {
    
    var email, password: String?
    
    func getRequestParameter() -> [String: String] {
        let lDict: [String: String] = ["email": (email ?? ""),
                                         "password": (password ?? "")]
        return lDict
    }
}
