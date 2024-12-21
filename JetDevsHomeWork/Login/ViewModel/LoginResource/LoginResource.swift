//
//  LoginResource.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation

struct LoginResource {
    
    func loginUser(loginRequest: LoginRequest, completion: @escaping LoginCompletionBlock) {
        APIManager().callAPIWithParameters(apiPath: loginUrl,
                                           requestType: .POST,
                                           parameters: loginRequest.getRequestParameter()
        ) {  (responseData, _, error) in
           // print("\(#function) \(#line) response : \(String(decoding: (responseData ?? Data()), as: UTF8.self)) --- error == \(String(describing: error?.localizedDescription))")
            if let lResponse = Utils.jsonfromData(objectData: responseData) {
                let lModel = LoginResoponseModel(dict: lResponse)
                if let lError = lModel.errorMessage,
                    lError.isEmpty == false {
                    completion(nil, lError)
                } else {
                    completion(lModel, nil)
                }
            } else {
                var lError = (error?.localizedDescription ?? "")
                if lError.isEmpty == true {
                    lError = "Body does not match"
                }
                completion(nil, lError)
                
            }
        }
    }
}
