//
//  NoteModel.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import Foundation

// 임시 모델
struct NoteModel: Codable {
    let id: Int
    let coffeeName: String
    let brand: String
    let drinkDate: String
    let sleepDate: String
    let comment: String
    let coffeeImgUrl: String
    let createdAt: String
}
