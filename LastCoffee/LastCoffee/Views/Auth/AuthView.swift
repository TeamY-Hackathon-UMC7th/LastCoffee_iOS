//
//  AuthView.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//
public let ScreenHeight = UIScreen.main.bounds.height
public let ScreenWidth = UIScreen.main.bounds.width

import UIKit
import SnapKit
import Then

class AuthView: UIView {
    
    lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "LastCoffeeText")
        $0.contentMode = .scaleAspectFit
    }
    
    let descriptionlabel = UILabel().then {
        $0.text = "사용할 닉네임을 입력해주세요"
        $0.textColor = .black
        $0.font = UIFont.ptdMediumFont(ofSize: 14)
    }
    
    lazy var nickNameField = DefaultTextField(
        textFieldPlaceholder: "닉네임을 입력해주세요",
        validationText: "사용할 수 없는 닉네임입니다."
    ).then {
        $0.textField.keyboardType = .default
    }
    
    let duplicateButton = CustomButton(
        backgroundColor: .gray,
        title: "중복확인",
        titleColor: .white,
        font: .ptdMediumFont(ofSize: 14),
        radius: 10,
        isEnabled: false
    )
    
    let checkButton = CustomButton(
        backgroundColor: .gray,
        title: "가입하기",
        titleColor: .white,
        font: .ptdSemiBoldFont(ofSize: 18),
        radius: 10,
        isEnabled: false
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [logoImageView, descriptionlabel, nickNameField, duplicateButton, checkButton].forEach {
            addSubview($0)
        }
    }

    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(140) // 상단 여백
            make.width.equalTo(ScreenWidth * 0.4)
            make.height.equalTo(ScreenHeight * 0.08)
        }
        
        descriptionlabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(logoImageView.snp.bottom).offset(60)
        }

        nickNameField.snp.makeConstraints { make in
            make.top.equalTo(descriptionlabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(ScreenWidth * 0.7)
            make.height.equalTo(52)
        }
        
        duplicateButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionlabel.snp.bottom).offset(10)
            make.leading.equalTo(nickNameField.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(nickNameField)
        }

        checkButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(ScreenHeight * 0.1)
        }
    }
}
