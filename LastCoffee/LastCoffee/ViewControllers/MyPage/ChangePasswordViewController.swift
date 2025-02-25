//
//  ChangePasswordViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    private let changePasswordView = ChangePasswordView()
    private var isValidPassword = false
    private var isValidNewPassword = false
    private var isValidConfirmPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = changePasswordView
        setProtocol()
        setNavigationBar()
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setProtocol(){
        changePasswordView.passwordView.textField.delegate = self
        changePasswordView.newPasswordView.textField.delegate = self
        changePasswordView.confirmPasswordView.textField.delegate = self
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.title = "비밀번호 변경"
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setAction(){
        // 현재 비밀번호
        changePasswordView.passwordView.textField.addTarget(self, action: #selector(validatePassword(_:)), for: .editingChanged)
        changePasswordView.passwordView.hiddenPasswordButton.addTarget(self, action: #selector(touchUpInsideHiddenPasswordButtonInPassword), for: .touchUpInside)
        
        // 새로운 비밀번호
        changePasswordView.newPasswordView.textField.addTarget(self, action: #selector(validatePassword(_:)), for: .editingChanged)
        changePasswordView.newPasswordView.hiddenPasswordButton.addTarget(self, action: #selector(touchUpInsideHiddenPasswordButtonInNewPassword), for: .touchUpInside)
        
        // 새로운 비밀번호 확인
        changePasswordView.confirmPasswordView.textField.addTarget(self, action: #selector(validatePassword(_:)), for: .editingChanged)
        changePasswordView.confirmPasswordView.hiddenPasswordButton.addTarget(self, action: #selector(touchUpInsideHiddenPasswordButtonInConfirmPassword), for: .touchUpInside)
        
        // 확인 버튼 액션
        changePasswordView.confirmButton.addTarget(self, action: #selector(touchUpInsideConfirmButton), for: .touchUpInside)
    }
    
    // 확인 버튼 액션
    @objc private func touchUpInsideConfirmButton() {
        // 비밀번호 변경 API 추가
        self.navigationController?.popViewController(animated: true)
    }
    
    // 비밀번호 필드 비밀번호 보기 액션 (현재 비밀번호)
    @objc private func touchUpInsideHiddenPasswordButtonInPassword(){
        changePasswordView.passwordView.setHiddenPassword()
    }
    
    // 비밀번호 필드 비밀번호 보기 액션 (새로운 비밀번호)
    @objc private func touchUpInsideHiddenPasswordButtonInNewPassword(){
        changePasswordView.newPasswordView.setHiddenPassword()
    }
    
    // 비밀번호 필드 비밀번호 보기 액션 (비밀번호 확인)
    @objc private func touchUpInsideHiddenPasswordButtonInConfirmPassword(){
        changePasswordView.confirmPasswordView.setHiddenPassword()
    }
    
    // 정규식 체크 함수
    @objc private func validatePassword(_ textField: UITextField) {
        let password = textField.text ?? ""
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@$_%^&+=])[A-Za-z\\d!@$_%^&+=]{8,20}$"

        let isValid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
        print("비밀번호 유효성 체크: \(isValid ? "✅ 유효함" : "❌ 유효하지 않음")")

        switch textField {
            // 현재 비밀번호
        case changePasswordView.passwordView.textField:
            self.isValidPassword = password != ""
            // 새로운 비밀번호 - 유효성 검사
        case changePasswordView.newPasswordView.textField:
            changePasswordView.newPasswordView.setErrorLabel(isError: !isValid, isEmpty: password == "")
            self.isValidNewPassword = isValid && password != ""
            confirmPassword()
            // 비밀번호 확인 - 새로운 비밀번호와 일치하는 지 확인
        case changePasswordView.confirmPasswordView.textField:
            confirmPassword()
        default:
            return
        }
        
        isEnableButton() // 확인 버튼 활성화 검사
     }
    
    // 비밀번호 일치 확인
    private func confirmPassword() {
        let newPassword = changePasswordView.newPasswordView.textField.text
        let confirmPassword = changePasswordView.confirmPasswordView.textField.text
        let isError = newPassword != confirmPassword
        let isEmpty = confirmPassword == ""
        
        self.isValidConfirmPassword = !isError && !isEmpty
        changePasswordView.confirmPasswordView.setErrorLabel(isError: isError, isEmpty: isEmpty)
    }
    
    // 버튼 활성화
    private func isEnableButton(){
        changePasswordView.confirmButton.setEnabled(isValidPassword && isValidNewPassword && isValidConfirmPassword)
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }

        // 입력 중인 텍스트 (현재 텍스트와 대체 텍스트를 합침)
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 20자까지만 받음
        if updatedText.count > 20 { return false }
        return true
    }
}
