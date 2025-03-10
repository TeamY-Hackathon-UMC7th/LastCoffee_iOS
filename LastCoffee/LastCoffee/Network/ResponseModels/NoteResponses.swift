//
//  NoteResponses.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import Foundation

public struct NotePreviewDTO : Codable {
    public let noteId : Int
    public let coffee : CoffeePreviewDTO
    public let writeDate : String
    public let drinkHour : Int
    public let sleepHour : Int
    
    public init(noteId: Int, coffee: CoffeePreviewDTO, writeDate: String, drinkHour: Int, sleepHour: Int) {
        self.noteId = noteId
        self.coffee = coffee
        self.writeDate = writeDate
        self.drinkHour = drinkHour
        self.sleepHour = sleepHour
    }
}

public struct GetAllNotesDTO : Codable {
    public let currentPage : Int
    public let totalPage : Int
    public let content : [NotePreviewDTO]?
    
    public init(currentPage: Int, totalPage: Int, content: [NotePreviewDTO]?) {
        self.currentPage = currentPage
        self.totalPage = totalPage
        self.content = content
    }
}

public struct NoteDTO : Codable {
    public let coffee : CoffeePreviewDTO
    public let writeDate : String
    public let drinkDate : String
    public let sleepDate : String
    public let review : String
    
    public init(coffee: CoffeePreviewDTO, writeDate: String, drinkDate: String, sleepDate: String, review: String) {
        self.coffee = coffee
        self.writeDate = writeDate
        self.drinkDate = drinkDate
        self.sleepDate = sleepDate
        self.review = review
    }
}

// FIX-ME 이렇게 하는거 맞나..?
public struct NewNotePreviewDTO : Codable {
    public let createdAt : String
    public let updatedAt : String
    public let id : Int
    public let writeDateTime : String
    public let drinkDateTime : String
    public let sleepDateTime : String
    public let review : String
}
