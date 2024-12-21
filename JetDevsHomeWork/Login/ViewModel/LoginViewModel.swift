//
//  LoginViewModel.swift
//  JetDevsHomeWork
//
//    20/12/24.
//

import Foundation

typealias LoginCompletionBlock = ((_ response: LoginResoponseModel?, _ error: String?) -> Void)

final class LoginViewModel {    
    
    func loginUser(loginRequest: LoginRequest, completion: @escaping LoginCompletionBlock) {
        let validationResult = LoginValidation().validate(loginRequest: loginRequest)
        if(validationResult.success) {
            // Use loginResource to call login API
            let loginResource = LoginResource()
            loginResource.loginUser(loginRequest: loginRequest) { [weak self] (responseData, error) in
                guard self != nil else {
                    completion(nil, nil)
                    return
                }
                self?.saveUserData(model: responseData)
                completion(responseData, error)
            }
        } else {
            completion(nil, validationResult.error)
        }
    }
    
    deinit {
        print("\(self) \(#function)")
    }
    
    private func saveUserData(model: LoginResoponseModel?) {
        guard let lUserModel = model?.data?.user else {
            return
        }
        
        Utils.saveContentInUserDefault(lUserModel.getUserInfoJson(), key: "UserInfo")
    }
}
