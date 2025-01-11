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
    public let status: Bool?
}

public struct CoffeeFirstDTO: Decodable {
    public let coffees: [CoffeeDetailResponse]
}

public struct Review: Decodable {
    public let createdAt : String
    public let updatedAt : String
    public let id : Int
    public let member: Member
    public let coffee: CoffeeDetailResponse
    public let drinkTime: String
    public let sleepTime: String
    public let comment: String
}

public struct Member: Decodable {
    public let id : Int
    public let nickname: String
}
