//
//  Request.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation

public struct TimeRequestDto : Codable {
    public var userTimeInput: String
    
    public init(userTimeInput: String) {
        self.userTimeInput = userTimeInput
    }
}

public struct ReviewDto : Codable {
    public let coffeeKey: Int
    public let comment: String
    public let drinkTime: String
    public let sleepTime: String
    
    public init(coffeeKey: Int, comment: String, drinkTime: String, sleepTime: String) {
        self.coffeeKey = coffeeKey
        self.comment = comment
        self.drinkTime = drinkTime
        self.sleepTime = sleepTime
    }
}

public func convertDateToISO8601(_ date: Date) -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // ISO 8601 형식 옵션
    formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC로 변환
    return formatter.string(from: date)
}

public func convertISO8601ToCustomFormat(_ dateString: String) -> String? {
    // 1. ISO 8601 Date Formatter
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    isoFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC 기준으로 파싱
    
    // 2. 입력된 문자열을 Date로 변환
    guard let date = isoFormatter.date(from: dateString) else {
        print("Invalid ISO8601 date string.")
        return nil
    }
    
    // 3. Custom Date Formatter
    let customFormatter = DateFormatter()
    customFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    customFormatter.timeZone = TimeZone.current // 로컬 시간대 사용
    
    // 4. Date를 원하는 형식의 문자열로 변환
    return customFormatter.string(from: date)
}
