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
    let networkService = AuthService()

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
        // 이렇게 불러주면 됨
        callLoginAPI(email: nickname, password: nickname)
//        self.goToNextView()
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
    
    func callLoginAPI(email: String, password: String) {
        // 비동기 작업 처리를 위한 Task Block
        Task {
            do { // 에러 핸들링을 위한 do-catch block
                // let 변수명 = try await 네트워크서비스에서 사용할 API -> DTO가 있으면 DTO 함수를 호출하여 넣어줌
                let data = try await networkService.postLoginAPI(data: networkService.makeLoginDTO(email: email, password: password))
                // 받아온 데이터로 이후 작업
                LoginViewController.keychain.set(data.accessToken, forKey: "accessToken")
                LoginViewController.keychain.set(data.refreshToken, forKey: "refreshToken")
                
                // UI 변경이 있다면, 이런식으로 작업 -> 여러가지라면 함수로 빼서 넣기
//                DispatchQueue.main.async {
//                     UI 업데이트
//                     UI 업데이트 함수 호출
//                }
            }
            catch {
                // 에러 핸들링 여기에(추후 작업)
                print(error)
            }
        }
    }
    
    // 기존 코드
//    func callLoginAPI(nickname: String) {
//        networkServcie.login(nickname: nickname) { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let response):
//                Task{
//                    LoginViewController.keychain.set(response.token, forKey: "serverAccessToken")
//                    LoginViewController.keychain.set(response.nickname, forKey: "userNickname")
//                    self.goToNextView()
//                }
//            case .failure(let error):
//                Toaster.shared.makeToast("\(error.errorDescription!)", .short)
//            }
//        }
//    }
    
}
