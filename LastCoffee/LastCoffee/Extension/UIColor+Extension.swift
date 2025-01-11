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
    
    static let mainColor = UIColor(hex: "994E24") // main color
    static let background = UIColor(hex: "FFF9F4") // 배경색
    static let action = UIColor(hex: "FF2929") // 액션 컬러

}
// Example
// let buttonColor = .mainColor // Hex: #994E24
// let backgroundColor = UIColor.background // Hex: #FFF9F4
