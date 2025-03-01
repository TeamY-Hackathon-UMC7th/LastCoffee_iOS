//
//  UIColor+Extension.swift
//  teamY
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

extension UIColor {
    // Hex 문자열을 UIColor로 변환하는 메서드
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        // Hex 문자열 길이에 따라 RGB 값을 추출
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        // UIColor 초기화
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// Example
// let buttonColor = UIColor(hex: "#314B9E")


extension UIColor {
    // 다크모드 적용을 위해서 에셋 사용
    static let mainColor = UIColor.main
    static let subColor = UIColor.sub
    static let background = UIColor.bg
    static let errorRed = UIColor.action
    static let rightGreen = UIColor(hex: "25C951") // 피그마에 컬러칩 업데이트가 안됨
    static let coffeeGray = UIColor(hex: "D4D4D4") // 피그마에 컬러칩 업데이트가 안됨
    
    static let neutral300 = UIColor(hex: "#8E8E8E")
    static let inputFieldBackground = UIColor(hex: "#FFFBF8") // 서치바와 리뷰 텍스트 배경색에 사용
}
