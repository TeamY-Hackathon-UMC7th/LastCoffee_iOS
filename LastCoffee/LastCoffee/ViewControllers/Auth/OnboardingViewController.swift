//
//  OnboardingViewController.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit
import KakaoSDKUser
import KeychainSwift
import SwiftyToaster

class OnboardingViewController: UIViewController {
    //MARK: - View
    private let onboardingView = KakaoLoginView()
    
    //MARK: - DI
    private lazy var kakaoAuthVM = KakaoViewModel()
    private let networkService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        viewSetting()
        setupActions()
    }
    
    func viewSetting() {
        view.addSubview(onboardingView)
        onboardingView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        onboardingView.kakaoBtn.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func kakaoLoginButtonTapped() {
        Task {
            await startKakaoLogin()
        }
    }
    
    private func startKakaoLogin() async {
        let success = await kakaoAuthVM.kakaoLogin()
        guard success else { return }

        do {
            let (userNickname, userEmail) = try await fetchKakaoUserInfo()
            await kakaoLoginProceed(userNickname, userEmail: userEmail)
        } catch {
            print("카카오 사용자 정보 가져오기 실패: \(error.localizedDescription)")
        }
    }
    
    private func fetchKakaoUserInfo() async throws -> (String, String) {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.me { user, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let userId = user?.id else {
                    continuation.resume(throwing: NSError(domain: "UserInfoError", code: -1, userInfo: nil))
                    return
                }
                guard let userEmail = user?.kakaoAccount?.email else {
                    continuation.resume(throwing: NSError(domain: "UserInfoError", code: -2, userInfo: nil))
                    return
                }
                continuation.resume(returning: (String(userId), userEmail))
            }
        }
    }
    
    private func kakaoLoginProceed(_ userIDString: String, userEmail: String) async {
        do {
            let kakaoDTO = networkService.makeLoginDTO(name: userIDString, email: userEmail)
            let response = try await networkService.postLoginAPI(data: kakaoDTO)
            
            // 토큰 저장
            SplashViewController.keychain.set(response.accessToken, forKey: "accessToken")
            SplashViewController.keychain.set(response.refreshToken, forKey: "refreshToken")
            
            DispatchQueue.main.async {
                self.goToNextView()
            }
        } catch {
            print("카카오 로그인 처리 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
    private func goToNextView() {
        let tabVC = MainTabBarController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let rootVC = UINavigationController(rootViewController: tabVC)
            
            window.rootViewController = rootVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }

}
