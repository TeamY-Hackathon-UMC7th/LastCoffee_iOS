//
//  Reviews.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import Foundation

struct ReviewsRequest: Codable {
    let coffeeKey: Int
    let drinkTime: String // 수정해야 됨
    let sleepTime: String
    let comment: String
}


struct ReviewsResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
}
