//
//  LogoutAlertViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit
import SwiftyToaster

protocol AlertViewControllerDelegate: AnyObject {
    func didDismissLogoutAlert()
}

class LogoutAlertViewController: UIViewController {
    weak var delegate: AlertViewControllerDelegate?
    private let logoutAlertView = LogoutAlertView()
    private lazy var kakaoAuthVM = KakaoViewModel()
    private let networkService = AuthService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = logoutAlertView
        
        setAction()
    }
    
    private func setAction() {
        logoutAlertView.cancelButton.addTarget(self, action: #selector(touchUpInsideCancelButton), for: .touchUpInside)
        
        logoutAlertView.confirmButton.addTarget(self, action: #selector(touchUpInsideConfirmButton), for: .touchUpInside)
    }
    
    // 취소 버튼 액션
    @objc private func touchUpInsideCancelButton() {
        delegate?.didDismissLogoutAlert()
        self.dismiss(animated: true)
    }
    
    // 확인 버튼 액션
    @objc private func touchUpInsideConfirmButton() {
        Task {
            do {
                await kakaoAuthVM.kakaoLogout()
                if !kakaoAuthVM.isLoggedIn {
                    let _ = try await networkService.postLogoutAPI()
                    kakaoAuthVM.deleteAllTokens()
                    goToNextView()
                }
            } catch {
                print("로그아웃 실패 : \(error.localizedDescription)")
            }
        }
    }
    
    private func goToNextView() {
        let tabVC = OnboardingViewController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first {
            let rootVC = UINavigationController(rootViewController: tabVC)
            
            window.rootViewController = rootVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
}


