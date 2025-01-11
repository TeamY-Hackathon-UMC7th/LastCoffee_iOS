//
//  LoginViewController.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit
import KeychainSwift
import SwiftyToaster

class LoginViewController: UIViewController {
    private let loginView = LoginView()
    public static let keychain = KeychainSwift()
    let networkServcie = AuthService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background

        viewSetting()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func viewSetting() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        loginView.nickNameField.textField.addTarget(self, action: #selector(usernameValidate), for: .allEditingEvents)
        loginView.joinQView.setJoinButtonAction(target: self, action: #selector(joinButtonTapped))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        loginView.checkButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    
    //MARK: - Interaction
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func usernameValidate() {
        let isButtonEnabled = validateUsername(loginView.nickNameField)
        loginView.checkButton.setEnabled(isButtonEnabled)
    }
    
    @objc private func joinButtonTapped() {
        let joinViewController = RegisterViewController()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(joinViewController, animated: true)
    }
    
    // push
    @objc private func loginButtonTapped() {
        guard let nickname = loginView.nickNameField.textField.text else { return }
        callLoginAPI(nickname: nickname)
    }
    
    func goToNextView() {
        let tabVC = MainTabBarController()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(tabVC, animated: true)
    }
    
    // 텍스트필드 검증
    func validateUsername(_ view: CustomTextFieldView) -> Bool {
        // 공백확인
        guard let username = view.text, !username.isEmpty else {
            return false
        }
        view.updateValidationText(text: "", isHidden: true)
        return true
    }
    
    func callLoginAPI(nickname: String) {
        networkServcie.login(nickname: nickname) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                Task{
                    LoginViewController.keychain.set(response.token, forKey: "serverAccessToken")
                    LoginViewController.keychain.set(response.nickname, forKey: "userNickname")
                    self.goToNextView()
                }
            case .failure(let error):
                Toaster.shared.makeToast("\(error.errorDescription!)", .short)
            }
        }
    }
    
}
