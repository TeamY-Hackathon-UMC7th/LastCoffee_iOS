//
//  KeychainKey.swift
//  LastCoffee
//
//  Created by 이수현 on 3/1/25.
//

import Foundation

public enum KeychainKey: String {
    case isOnAlert = "알림 설정"
    case alertTime = "알림 시간"
    case accessToken = "accessToken"
    case refreshToken = "refreshToken"
    case accessTokenExpires = "accessTokenExpires"
    case refreshTokenExpires = "refreshTokenExpires"
}
