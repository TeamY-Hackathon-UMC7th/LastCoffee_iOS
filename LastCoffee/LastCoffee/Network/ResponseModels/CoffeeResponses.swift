//
//  CoffeeResponses.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import UIKit

public struct CoffeePreviewDTO : Codable, Hashable {
    public let id : Int
    public let brand : String
    public let coffeeName : String
    public let coffeeImgUrl : String
    
    public init(id: Int, brand: String, coffeeName: String, coffeeImgUrl: String) {
        self.id = id
        self.brand = brand
        self.coffeeName = coffeeName
        self.coffeeImgUrl = coffeeImgUrl
    }
}

public struct CoffeeDetailPreviewDTO : Codable {
    public let coffeeName : String
    public let brand : String
    public let caffeine : Int
    public let drinkCount : Int
    public let coffeeImgUrl : String
    
    public init(coffeeName: String, brand: String, caffeine: Int, drinkCount: Int, coffeeImgUrl: String) {
        self.coffeeName = coffeeName
        self.brand = brand
        self.caffeine = caffeine
        self.drinkCount = drinkCount
        self.coffeeImgUrl = coffeeImgUrl
    }
}

public struct CoffeeDetailDTO: Codable {
    let id: Int
    let name: String
    let brand: String
    let sugar: Int
    let caffeine: Int
    let calories: Int
    let protein: Int
    let coffeeImgUrl: String
    
    init(id: Int, name: String, brand: String, sugar: Int, caffeine: Int, calories: Int, protein: Int, coffeeImgUrl: String) {
        self.id = id
        self.name = name
        self.brand = brand
        self.sugar = sugar
        self.caffeine = caffeine
        self.calories = calories
        self.protein = protein
        self.coffeeImgUrl = coffeeImgUrl
    }
}

public struct SearchResponse: Codable {
    public let coffeeResponseDtos: [CoffeeDetailDTO]
    public let listSize: Int
    public let totalPage: Int
    public let totalElements: Int
    public let isFirst: Bool
    public let isLast: Bool
}
