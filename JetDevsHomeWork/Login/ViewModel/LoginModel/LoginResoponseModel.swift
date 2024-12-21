//
//  LoginResoponseModel.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation

// Root structure
struct LoginResoponseModel {
    
    let result: Int?
    let errorMessage: String?
    let data: UserData?
    
    public init(dict: [String: Any]?) {
        self.result = dict?["result"] as? Int
        self.errorMessage = dict?["error_message"] as? String
        self.data = UserData(dict: dict?["data"] as? [String: Any])
    }
}

// Nested structure for user data
struct UserData {
    
    let user: User?
    init(dict: [String: Any]?) {
        self.user = User(dict: dict?["user"] as? [String: Any])
    }
}

// User details
struct User {
    
    let userId: Int?
    let userName: String?
    let userProfileURL: String?
    let createdAt: String?
    
    init(dict: [String: Any]?) {
        self.userId = dict?["user_id"] as? Int
        self.userName = dict?["user_name"] as? String
        self.userProfileURL = dict?["user_profile_url"] as? String
        self.createdAt = dict?["created_at"] as? String
    }
    
    func getUserInfoJson() -> [String: Any]? {
        
        var lDict: [String: Any] = [String: Any]()
        lDict["user_id"] = self.userId
        lDict["user_name"] = self.userName
        lDict["user_profile_url"] = self.userProfileURL
        lDict["created_at"] = self.createdAt
        return lDict
    }
}
