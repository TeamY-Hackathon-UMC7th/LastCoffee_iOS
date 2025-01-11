//
//  CoffeeData.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation
import SwiftData

@Model // SwiftData 모델 선언
public class CoffeeData {
    public var searchTime: String
    @Attribute(.unique) public var id: Int
    public var name: String
    public var brand: String
    public var sugar: Int
    public var caffeine: Int
    public var calories: Int
    public var protein: Int
    public var coffeeImgUrl: String
    
    public init(searchTime: String, id: Int, name: String, brand: String, sugar: Int, caffeine: Int, calories: Int, protein: Int, coffeeImgUrl: String) {
        self.searchTime = searchTime
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
