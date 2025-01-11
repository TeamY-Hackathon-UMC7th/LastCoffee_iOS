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
        if canUser {
            registerView.nickNameField.updateValidationText(text: "사용 가능한 닉네임입니다.", isHidden: false, color: UIColor.rightGreen)
            registerView.checkButton.setEnabled(true)
        } else {
            registerView.nickNameField.updateValidationText(text: "중복된 닉네임입니다.", isHidden: false, color: UIColor.errorRed)
        }
    }
    
    func callCheckAPI(nickname: String) {
        networkService.checkEmail(nickname: nickname) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.canUser = response.status
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func joinButtonTapped() {
        // api call
        // TODO : 회원가입 API 연결
        self.navigationController?.popViewController(animated: true)
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
