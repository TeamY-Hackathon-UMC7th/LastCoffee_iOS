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

public struct GettAppNotesDTO : Codable {
    public let currentPage : Int
    public let totalPage : Int
    public let content : [NotePreviewDTO]?
    
    public init(currentPage: Int, totalPage: Int, content: [NotePreviewDTO]?) {
        self.currentPage = currentPage
        self.totalPage = totalPage
        self.content = content
    }
}
