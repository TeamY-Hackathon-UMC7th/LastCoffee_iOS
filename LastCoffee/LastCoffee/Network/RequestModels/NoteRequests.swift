//
//  NoteRequests.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import Foundation

public struct NewNoteDTO : Codable {
    public var drinkDateTime : String
    public var sleepDateTime : String
    public var review : String
    public var coffeeId : Int
    
    public init(drinkDateTime: Date, sleepDateTime: Date, review: String, coffeeId: Int) {
        self.drinkDateTime = formatDate(drinkDateTime)
        self.sleepDateTime = formatDate(sleepDateTime)
        self.review = review
        self.coffeeId = coffeeId
    }
}

// 날짜 변환 함수
func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale(identifier: "ko_KR")

    return dateFormatter.string(from: date)
}
