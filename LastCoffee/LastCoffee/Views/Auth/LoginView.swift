//
//  AuthView.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit
import SnapKit
import Then

class LoginView: UIView {
    
    lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "LastCoffee")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .brown
    }
    
    let descriptionlabel = UILabel().then {
        $0.text = "사용할 닉네임을 입력해주세요"
        $0.textColor = .black
        $0.font = UIFont.ptdMediumFont(ofSize: 14)
    }
    
    lazy var nickNameField = CustomTextFieldView(
        descriptionImageIcon: "coffee",
        textFieldPlaceholder: "닉네임을 입력해주세요",
        validationText: "사용할 수 없는 닉네임입니다."
    ).then {
        $0.textField.keyboardType = .default
    }
    
    let checkButton = CustomButton(
        backgroundColor: .gray,
        title: "로그인",
        titleColor: .white,
        font: .ptdSemiBoldFont(ofSize: 18),
        radius: 10,
        isEnabled: false
    )
    
    let joinQView = JoinStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [logoImageView, descriptionlabel, nickNameField, checkButton, joinQView].forEach {
            addSubview($0)
        }
    }

    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(128) // 상단 여백
            make.width.equalTo(ScreenWidth * 0.3)
        }

        nickNameField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(65)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }

        checkButton.snp.makeConstraints { make in
            make.top.equalTo(nickNameField.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        joinQView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(checkButton.snp.bottom).offset(14)
        }
    }
}
