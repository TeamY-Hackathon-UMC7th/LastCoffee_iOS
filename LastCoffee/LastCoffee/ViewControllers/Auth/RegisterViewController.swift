//
//  RegisterViewController.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit

class RegisterViewController: UIViewController {
    private let registerView = AuthView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        // api call
        // TODO : 중복체크 API 연결
        
//        let isButtonEnabled = // api call success
//        registerView.checkButton.setEnabled(isButtonEnabled)
        registerView.nickNameField.updateValidationText(text: "사용 가능한 닉네임입니다.", isHidden: false, color: .green)
        registerView.checkButton.setEnabled(true)
        // 중복이면
//        registerView.nickNameField.updateValidationText(text: "중복된 닉네임입니다.", isHidden: false, color: .red)
        
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
