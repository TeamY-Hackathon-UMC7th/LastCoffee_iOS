//
//  CoffeeDetailResponse.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import Foundation

public struct CoffeeDetailResponse: Decodable {
    public let id: Int
    public let name: String
    public let brand: String
    public let sugar: Int
    public let caffeine: Int
    public let calories: Int
    public let protein: Int
    public let coffeeImgUrl: String
}
