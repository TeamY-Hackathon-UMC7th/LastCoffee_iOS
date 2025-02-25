//
//  ChangeNicknameViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class ChangeNicknameViewController: UIViewController {
    private let changeNicknameView = ChangeNicknameView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = changeNicknameView
        
        changeNicknameView.textField.delegate = self
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
    
    private func setAction() {
        // 닉네임 텍스트 필드 검증
        changeNicknameView.textField.addTarget(self, action: #selector(confirmTextField), for: .editingChanged)
        
        // 확인 버튼 액션
        changeNicknameView.confirmButton.addTarget(self, action: #selector(touchUpInsideConfirmButton), for: .touchUpInside)
    }
    
    // 확인 버튼 액션
    @objc private func touchUpInsideConfirmButton() {
        // 닉네임 변경 API 처리
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.title = "닉네임 변경"
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func confirmTextField() {
        let text = changeNicknameView.textField.text
        changeNicknameView.setTextFieldFillAction(isFill: text != "")
    }
}


extension ChangeNicknameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        // 입력 중인 텍스트 (현재 텍스트와 대체 텍스트를 합침)
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 10자 이상 입력 받지 않음
        if updatedText.count > 9 {
            self.changeNicknameView.checkNicknameLength(isLong: true)
            return false
        } else {
            self.changeNicknameView.checkNicknameLength(isLong: false)
        }
        return true
    }
}
