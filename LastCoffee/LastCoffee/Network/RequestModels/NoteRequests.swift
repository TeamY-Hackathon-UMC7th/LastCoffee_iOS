//
//  NoteRequests.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import Foundation

public struct NewNoteDTO : Codable {
    public let writeDate : String
    public let drinkDate : String
    public let drinkHour : String
    public let drinkMinute : String
    public let sleepDate : String
    public let sleepHour : String
    public let sleepMinute : String
    public let review : String
    public let coffeeId : Int
    
    public init(writeDate: String, drinkDate: String, drinkHour: String, drinkMinute: String, sleepDate: String, sleepHour: String, sleepMinute: String, review: String, coffeeId: Int) {
        self.writeDate = writeDate
        self.drinkDate = drinkDate
        self.drinkHour = drinkHour
        self.drinkMinute = drinkMinute
        self.sleepDate = sleepDate
        self.sleepHour = sleepHour
        self.sleepMinute = sleepMinute
        self.review = review
        self.coffeeId = coffeeId
    }
}
