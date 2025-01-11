//
//  CoffeeDetailResponse.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import Foundation

struct CoffeeDetailResponse: Codable {
    let id: Int
    let name: String
    let brand: String
    let sugar: Int
    let caffeine: Int
    let calories: Int
    let protein: Int
    let coffeeImgUrl: String
}
