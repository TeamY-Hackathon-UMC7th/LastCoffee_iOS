//
//  NoteModel.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import Foundation

// 임시 모델
struct NoteModel: Codable {
    let coffeeName: String
    let drinkingDate: String
    let drinkingTime: String
    let sleepingDate: String
    let sleepingTime: String
    let review: String
}
