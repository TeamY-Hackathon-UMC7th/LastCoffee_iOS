//
//  NoteModel.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import Foundation

struct NoteModel: Codable {
    let id: Int
    let brand: String
    let coffeeName: String
    let coffeeImgUrl: String
    let writeDate: String
    let drinkHour: Int
    let sleepHour: Int
}

struct NoteDetailModel: Codable {
    let id: Int
    let brand: String
    let coffeeName: String
    let coffeeImgUrl: String
    let writeDate: String
    let drinkDate: String
    let sleepDate: String
    let review: String
}
