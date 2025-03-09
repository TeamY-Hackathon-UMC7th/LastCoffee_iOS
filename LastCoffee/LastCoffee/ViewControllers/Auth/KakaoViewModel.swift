//
//  KakaoViewModel.swift
//  LastCoffee
//
//  Created by 김도연 on 3/4/25.
//

import UIKit

import Combine

import KakaoSDKAuth
import KakaoSDKUser
import KeychainSwift

final class KakaoViewModel: ObservableObject {
    public var subscriptions = Set<AnyCancellable>()

    @Published public var isLoggedIn: Bool = false
    @Published public var errorMessage: String? // 에러 메시지를 저장하는 변수
    
    // 사용자 토큰 저장을 위한 변수
    @Published public private(set) var oauthToken: String? {
        didSet {
            isLoggedIn = oauthToken != nil
        }
    }
    
    public init() {
        print("KakaoAuthVM - init() called")
    }
    
    //MARK: - Concurrency funcs
    /// Login
    @MainActor
    public func kakaoLogin() async -> Bool {
        do {
            if UserApi.isKakaoTalkLoginAvailable() {
                let token = try await loginWithKakaoTalk()
                print("카카오톡 로그인 성공: \(token)")
                return true
            } else {
                let token = try await loginWithKakaoAccount()
                print("카카오 계정 로그인 성공: \(token)")
                return true
            }
        } catch {
            print("카카오 로그인 실패: \(error.localizedDescription)")
            errorMessage = "로그인 실패: \(error.localizedDescription)"
            return false
        }
    }
    
    /// logout
    @MainActor
    public func kakaoLogout() async {
        let success = await handleKakaoLogOut()
        if success {
            isLoggedIn = false
        }
    }
    
    /// unlink
    public func unlinkKakaoAccount() async -> Bool {
        return await withCheckedContinuation { continuation in
            UserApi.shared.unlink { error in
                if let error = error {
                    print("카카오 계정 연동 해제 실패: \(error.localizedDescription)")
                    continuation.resume(returning: false) // 실패 시 false 반환
                } else {
                    print("카카오 계정 연동 해제 성공")
                    continuation.resume(returning: true) // 성공 시 true 반환
                }
            }
        }
    }
    
    public func deleteAllTokens() {
        ["accessToken", "refreshToken"].forEach {
            SplashViewController.keychain.delete($0)
        }
    }
    
    
    //MARK: - Completion Funcs
    @MainActor
    public func kakaoLogin(completion: @escaping (Bool) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("카카오톡 로그인 실패: \(error.localizedDescription)")
                    completion(false)
                } else if oauthToken != nil {
                    print("카카오톡 로그인 성공")
                    completion(true)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("카카오 계정 로그인 실패: \(error.localizedDescription)")
                    completion(false)
                } else if oauthToken != nil {
                    print("카카오 계정 로그인 성공")
                    completion(true)
                }
            }
        }
    }
    
    public func unlinkKakaoAccount(completion : @escaping (Bool) -> Void) {
        UserApi.shared.unlink { error in
            if let error = error {
                print("카카오 계정 연동 해제 실패: \(error.localizedDescription)")
                completion(false)
            }
            print("카카오 계정 연동 해제 성공")
            completion(true)
        }
    }
    
    @MainActor
    public func kakaoLogout() {
        Task {
            if await handleKakaoLogOut() {
                self.isLoggedIn = false
            }
        }
    }
    
    
    //MARK: - Private Funcs
    // 카카오톡 앱
    private func loginWithKakaoTalk() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let token = oauthToken {
                    continuation.resume(returning: token)
                }
            }
        }
    }
    
    // 카카오 계정 직접 입력
    private func loginWithKakaoAccount() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let token = oauthToken {
                    continuation.resume(returning: token)
                }
            }
        }
    }
    
    // 카카오 로그아웃
    private func handleKakaoLogOut() async -> Bool {
        return await withCheckedContinuation { continuation in
            UserApi.shared.logout { [weak self] error in
                if let error = error {
                    print("카카오 로그아웃 실패: \(error.localizedDescription)")
                    self?.errorMessage = "로그아웃 실패: \(error.localizedDescription)"
                    continuation.resume(returning: false)
                } else {
                    print("카카오 로그아웃 성공")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
}
