//
//  String+Extension.swift
//  LastCoffee
//
//  Created by 이수현 on 3/1/25.
//

import Foundation

extension String {
    // '오전 12시'와 같이 바꿔줌
    var toKoreanTimeString: String {
        guard let hour = Int(self), hour >= 0 && hour < 24 else { return "잘못된 시간" }
        
        let period = hour < 12 ? "오전" : "오후"
        let formattedHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour)
        
        return "\(period) \(formattedHour)시"
    }
}
