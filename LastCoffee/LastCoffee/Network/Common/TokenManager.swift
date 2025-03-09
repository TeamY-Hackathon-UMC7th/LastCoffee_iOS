//
//  TokenManager.swift
//  LastCoffee
//
//  Created by 김도연 on 3/9/25.
//

import Foundation
import KeychainSwift

final class TokenManager {
    static let shared = TokenManager()
    private let keychain = KeychainSwift()
    
    private init() {}
    
    func saveValue(key: String, value: String) {
        keychain.set(value, forKey: key)
    }
    
    func removeValue(key: String) {
        keychain.delete(key)
    }
    
    func getValue(key: String) -> String? {
        return keychain.get(key)
    }
    
    func getValue(key: String) -> Bool? {
        return keychain.getBool(key)
    }
    
    func saveValue(key: String, value: Bool) {
        keychain.set(value, forKey: key)
    }
    
    func saveAccessToken(_ token: String, expiresIn: TimeInterval) {
        keychain.set(token, forKey: KeychainKey.accessToken.rawValue)
        let expirationDate = Date().addingTimeInterval(expiresIn)
        keychain.set("\(expirationDate.timeIntervalSince1970)", forKey: KeychainKey.accessTokenExpires.rawValue)
    }

    func saveRefreshToken(_ token: String, expiresIn: TimeInterval) {
        keychain.set(token, forKey: KeychainKey.refreshToken.rawValue)
        let expirationDate = Date().addingTimeInterval(expiresIn)
        keychain.set("\(expirationDate.timeIntervalSince1970)", forKey: KeychainKey.refreshTokenExpires.rawValue)
    }

    func getAccessToken() -> String? {
        return keychain.get(KeychainKey.accessToken.rawValue)
    }

    func getRefreshToken() -> String? {
        return keychain.get(KeychainKey.refreshToken.rawValue)
    }
    
    func getAccessTokenExpiration() -> Date? {
        guard let timestamp = keychain.get(KeychainKey.accessTokenExpires.rawValue),
              let timeInterval = TimeInterval(timestamp) else {
            return nil
        }
        return Date(timeIntervalSince1970: timeInterval)
    }

    func getRefreshTokenExpiration() -> Date? {
        guard let timestamp = keychain.get(KeychainKey.refreshTokenExpires.rawValue),
              let timeInterval = TimeInterval(timestamp) else {
            return nil
        }
        return Date(timeIntervalSince1970: timeInterval)
    }

    func clearTokens() {
        keychain.delete(KeychainKey.accessToken.rawValue)
        keychain.delete(KeychainKey.refreshToken.rawValue)
        keychain.delete(KeychainKey.accessTokenExpires.rawValue)
        keychain.delete(KeychainKey.refreshTokenExpires.rawValue)
    }

    func isAccessTokenValid() -> Bool {
        guard let expirationDate = getAccessTokenExpiration() else {
            return false
        }
        return expirationDate > Date()
    }

    func isRefreshTokenValid() -> Bool {
        guard let expirationDate = getRefreshTokenExpiration() else {
            return false
        }
        return expirationDate > Date()
    }
    
}
