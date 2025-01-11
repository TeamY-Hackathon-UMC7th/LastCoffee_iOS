//
//  CoffeeDetailResponse.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import Foundation


public struct CoffeeDetailResponse: Codable, Hashable {
    let id: Int
    let name: String
    let brand: String
    let sugar: Int
    let caffeine: Int
    let calories: Int
    let protein: Int
    let coffeeImgUrl: String
}


extension CoffeeDetailResponse {
    static func dummy() -> [CoffeeDetailResponse] {
        return [
            CoffeeDetailResponse(id: 1, name: "헤이즐 넛 콜드브루", brand: "스타벅스", sugar: 13, caffeine: 120, calories: 500, protein: 5, coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
            CoffeeDetailResponse(id: 2, name: "헤이즐 넛 콜드브루", brand: "스타벅스", sugar: 13, caffeine: 120, calories: 500, protein: 5, coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
            CoffeeDetailResponse(id: 3, name: "헤이즐 넛 콜드브루", brand: "스타벅스", sugar: 13, caffeine: 120, calories: 500, protein: 5, coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
            CoffeeDetailResponse(id: 4, name: "헤이즐 넛 콜드브루", brand: "스타벅스", sugar: 13, caffeine: 120, calories: 500, protein: 5, coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
            CoffeeDetailResponse(id: 5, name: "헤이즐 넛 콜드브루", brand: "스타벅스", sugar: 13, caffeine: 120, calories: 500, protein: 5, coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
            CoffeeDetailResponse(id: 6, name: "헤이즐 넛 콜드브루", brand: "스타벅스", sugar: 13, caffeine: 120, calories: 500, protein: 5, coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
        ]
    }
}
