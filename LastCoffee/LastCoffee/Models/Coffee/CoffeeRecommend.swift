//
//  CoffeeRecommend.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import Foundation

struct CoffeeRecommendRequest: Codable {
    let userTimeInput: String
}

struct CoffeeRecommendResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [CoffeeDetailResponse]
}

