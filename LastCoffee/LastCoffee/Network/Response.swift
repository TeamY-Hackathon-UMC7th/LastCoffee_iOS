//
//  Response.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation

public struct LoginResponseDto : Decodable {
    public let nickname: String
    public let token: String
}


public struct JoinResponseDto: Decodable {
    public let status: Bool
}
