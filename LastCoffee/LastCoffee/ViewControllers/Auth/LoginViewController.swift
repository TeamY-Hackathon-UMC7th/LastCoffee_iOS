//
//  LoginViewController.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit

class LoginViewController: UIViewController {
    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        viewSetting()
        setupActions()
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
        self.navigationController?.pushViewController(joinViewController, animated: true)
    }
    
    // push
    @objc private func loginButtonTapped() {
        let tabVC = MainTabBarController()
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
    
}
