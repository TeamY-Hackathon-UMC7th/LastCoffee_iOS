//
//  AuthResponses.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import UIKit

public struct LoginResponseDTO : Codable {
    public let id : Int
    public let nickName: String
    public let email : String
    public let accessToken : String
    public let refreshToken : String
    public let accessTokenExpiresIn : TimeInterval
    public let refreshTokenExpiresIn : TimeInterval
    
    public init(id: Int, nickName: String, email: String, accessToken: String, refreshToken: String, accessTokenExpiresIn: TimeInterval, refreshTokenExpiresIn: TimeInterval) {
        self.id = id
        self.nickName = nickName
        self.email = email
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.accessTokenExpiresIn = accessTokenExpiresIn
        self.refreshTokenExpiresIn = refreshTokenExpiresIn
    }
}
