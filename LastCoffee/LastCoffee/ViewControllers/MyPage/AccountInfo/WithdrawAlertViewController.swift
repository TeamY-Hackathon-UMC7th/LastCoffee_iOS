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
    private let authService = AuthService()
    
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
        withdrawUser()
    }
    
    // 회원 탈퇴 API
    private func withdrawUser(){
        Task {
            do {
                let result = try await authService.deleteUserAPI()
                Toaster.shared.makeToast(result)
                
                LoginViewController.keychain.delete("accessToken")
                LoginViewController.keychain.delete("refreshToken")
                LoginViewController.keychain.delete("serverAccessToken")
                LoginViewController.keychain.delete(KeychainKey.alertTime.rawValue)
                LoginViewController.keychain.delete(KeychainKey.isOnAlert.rawValue)
                LocalNotificationHelper.shared.removeAllNotification() // 모든 알림 삭제
                
                navigationController?.popToRootViewController(animated: true) // 로그인 뷰로 이동
            }
            catch {
                print(error.localizedDescription)
                Toaster.shared.makeToast("회원탈퇴에 실패했습니다.")
            }
        }
    }
}


