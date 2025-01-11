//
//  RegisterViewController.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit

class RegisterViewController: UIViewController {
    private let registerView = AuthView()
    let networkService = AuthService()
    
    var canUser : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        viewSetting()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func viewSetting() {
        view.addSubview(registerView)
        registerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        registerView.nickNameField.textField.addTarget(self, action: #selector(usernameValidate), for: .allEditingEvents)
        registerView.duplicateButton.addTarget(self, action: #selector(checkDuplicateButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        registerView.checkButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Interaction
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func usernameValidate() {
        let isButtonEnabled = validateUsername(registerView.nickNameField)
        registerView.duplicateButton.setEnabled(isButtonEnabled)
    }
    
    @objc private func checkDuplicateButtonTapped() {
        guard let nickname = registerView.nickNameField.textField.text else { return }
        callCheckAPI(nickname: nickname)
    }
    
    func callCheckAPI(nickname: String) {
        networkService.checkEmail(nickname: nickname) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                // 비동기 UI 업데이트
                DispatchQueue.main.async {
                    self.canUser = response.status
                    
                    if self.canUser {
                        self.registerView.nickNameField.updateValidationText(
                            text: "사용 가능한 닉네임입니다.",
                            isHidden: false,
                            color: UIColor.rightGreen
                        )
                        self.registerView.checkButton.setEnabled(true)
                    } else {
                        self.registerView.nickNameField.updateValidationText(
                            text: "중복된 닉네임입니다.",
                            isHidden: false,
                            color: UIColor.errorRed
                        )
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.registerView.nickNameField.updateValidationText(
                        text: "오류가 발생했습니다. 다시 시도해주세요.",
                        isHidden: false,
                        color: UIColor.errorRed
                    )
                }
            }
        }
    }
    
    func callJoinAPI(nickname: String) {
        networkService.join(nickname: nickname) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                Task{
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func joinButtonTapped() {
        guard let nickname = registerView.nickNameField.textField.text else { return }
        callJoinAPI(nickname: nickname)
    }
    
    // 텍스트필드 검증
    func validateUsername(_ view: DefaultTextField) -> Bool {
        // 공백확인
        guard let username = view.text, !username.isEmpty else {
            return false
        }
        view.updateValidationText(text: "", isHidden: true)
        return true
    }
    
}
