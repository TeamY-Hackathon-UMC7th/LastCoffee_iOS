//
//  AuthRequests.swift
//  LastCoffee
//
//  Created by 김도연 on 2/25/25.
//

import Foundation

public struct ChangePasswordRequestDTO : Codable {
    public var currentPassword : String
    public var updatePassword : String
    public var checkPassword : String
    
    public init(currentPassword: String, updatePassword: String) {
        self.currentPassword = currentPassword
        self.updatePassword = updatePassword
        self.checkPassword = updatePassword
    }
}

public struct LoginRequestDTO : Codable {
    public var kakaoName : String
    public var kakaoEmail : String
    
    public init(kakaoName: String, kakaoEmail: String) {
        self.kakaoName = kakaoName
        self.kakaoEmail = kakaoEmail
    }
}

public struct JoinRequestDTO : Codable {
    public var email : String
    public var password : String
    public var checkPassword : String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
        self.checkPassword = password
    }
}
