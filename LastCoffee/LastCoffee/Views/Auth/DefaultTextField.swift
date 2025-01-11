//
//  CustomTextField.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit
import SnapKit

public class DefaultTextField: UIView, UITextFieldDelegate {
    // MARK: - Properties
    public let textField: PaddedTextField
    let validationLabel: UILabel
    
    public var text: String? {
        get {
            return textField.text
        }
        set(emailString) {
            textField.text = emailString
        }
    }
    
    // MARK: - 초기화
    public init(textFieldPlaceholder: String,
                validationText: String) {
        // 초기화
        self.textField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)) // Padding 초기화
        self.validationLabel = UILabel()
        
        super.init(frame: .zero)
        
        setupUI(textFieldPlaceholder: textFieldPlaceholder,
                validationText: validationText)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 세팅
    private func setupUI(textFieldPlaceholder: String, validationText: String) {
        
        // 텍스트 필드 설정
        textField.placeholder = textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        textField.layer.borderColor = UIColor.brown.cgColor
        textField.layer.borderWidth = 0.7
        textField.layer.cornerRadius = 10
        
        validationLabel.text = validationText
        validationLabel.textColor = UIColor.red
        validationLabel.font = UIFont.systemFont(ofSize: 12)
        validationLabel.isHidden = true
        
        let placeholderColor = UIColor.gray
        textField.attributedPlaceholder = NSAttributedString(
            string: textFieldPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        
        addSubview(textField)
        addSubview(validationLabel)
        
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
        }
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.leading.equalTo(textField.snp.leading).offset(8)
        }
    }
    
    public func updateValidationText(text: String, isHidden: Bool, color: UIColor? = nil) {
        validationLabel.text = text
        validationLabel.isHidden = isHidden
        validationLabel.textColor = color
        textField.layer.borderColor = color?.cgColor
    }
    
    private func showCharacterLimit(message: String) {
        validationLabel.text = message
        validationLabel.isHidden = false
        validationLabel.textColor = UIColor.red
    }
    
    // MARK: - 텍스트필드 델리게이트
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        // 입력 중인 텍스트 (현재 텍스트와 대체 텍스트를 합침)
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 한글 입력 중인지 확인
        if let markedTextRange = textField.markedTextRange,
           let _ = textField.position(from: markedTextRange.start, offset: 0) {
            return true
        }
        
        // 10자 이상 입력 받지 않음
        if updatedText.count > 9 {
            self.showCharacterLimit(message: "닉네임은 10자 이상 입력할 수 없습니다.")
            return false
        }
        return true
    }
}
