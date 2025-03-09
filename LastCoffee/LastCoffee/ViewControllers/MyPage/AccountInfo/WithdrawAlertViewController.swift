//
//  WithdrawAlertViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit
import SwiftyToaster

class WithdrawAlertViewController: UIViewController {
    weak var delegate: AlertViewControllerDelegate?
    private let withdrawAlertView = WithdrawAlertView()
    private lazy var kakaoAuthVM = KakaoViewModel()
    private let networkService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = withdrawAlertView
        
        setAction()
    }
    
    private func setAction() {
        withdrawAlertView.cancelButton.addTarget(self, action: #selector(touchUpInsideCancelButton), for: .touchUpInside)
        
        withdrawAlertView.withdrawButton.addTarget(self, action: #selector(touchUpInsideWithdrawButton), for: .touchUpInside)
    }
    
    // 취소 버튼 액션
    @objc private func touchUpInsideCancelButton() {
        delegate?.didDismissLogoutAlert()
        self.dismiss(animated: true)
    }
    
    // 탈퇴 버튼 액션
    @objc private func touchUpInsideWithdrawButton() {
        Task {
            do {
                let isUnlink = await kakaoAuthVM.unlinkKakaoAccount()
                if isUnlink {
                    let _ = try await networkService.deleteUserAPI()
                    kakaoAuthVM.deleteAllTokens()
                    goToNextView()
                } else {
                    throw NSError(domain: "KakaoInnerError", code: -1, userInfo: nil)
                }
            } catch {
                print("탈퇴 실패 : \(error.localizedDescription)")
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


