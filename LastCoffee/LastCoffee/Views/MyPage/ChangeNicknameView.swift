//
//  ChangeNicknameView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class ChangeNicknameView: UIView {
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "닉네임"
        lbl.textColor = UIColor(hex: "592401")
        lbl.font = .ptdMediumFont(ofSize: 16)
    }
    
    public let textField = UITextField().then { txt in
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        txt.leftView = leftView
        txt.leftViewMode = .always
        txt.placeholder = "닉네임을 입력해주세요"
        txt.font = .ptdRegularFont(ofSize: 14)
        txt.layer.cornerRadius = 6
        txt.layer.borderColor = UIColor(hex: "A1A1A1")?.cgColor
        txt.layer.borderWidth = 0.7
    }
    
    private let errorLabel = UILabel().then { lbl in
        lbl.text = "닉네임을 10글자 이하로 설정해주세요"
        lbl.textColor = .errorRed
        lbl.font = .ptdMediumFont(ofSize: 12)
        lbl.isHidden = true
    }
    
    // 확인 버튼
    public let confirmButton = CustomButton().then { btn in
        btn.configure(title: "확인", titleColor: .white, font: .ptdSemiBoldFont(ofSize: 18), radius: 6, backgroundColor: UIColor(hex: "#D4D4D4") ?? .mainColor, isEnabled: false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .background
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            titleLabel,
            textField,
            confirmButton,
            errorLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(DynamicPadding.dynamicValue(50))
            make.leading.equalTo(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(DynamicPadding.dynamicValue(52))
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(DynamicPadding.dynamicValue(76))
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(DynamicPadding.dynamicValue(52))
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(3)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    public func setTextFieldFillAction(isFill: Bool){
        self.textField.layer.borderColor = isFill ? UIColor(hex: "592401")?.cgColor : UIColor(hex: "A1A1A1")?.cgColor
        self.confirmButton.setEnabled(isFill)
    }
    
    public func checkNicknameLength(isLong: Bool){
        errorLabel.isHidden = !isLong
    }
}
