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
    private let authService = AuthService()
    
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
        postLogout()
    }
    
    // 로그아웃 API
    private func postLogout() {
        Task {
            do {
                let result = try await authService.postLogoutAPI()
                Toaster.shared.makeToast(result)

                LoginViewController.keychain.delete("accessToken")
                LoginViewController.keychain.delete("refreshToken")
                LoginViewController.keychain.delete("serverAccessToken")
                
                navigationController?.popToRootViewController(animated: true) // 로그인 뷰로 이동
            }
            catch {
                print(error.localizedDescription)
                Toaster.shared.makeToast("로그아웃 실패했습니다.")
            }
        }
    }
}


