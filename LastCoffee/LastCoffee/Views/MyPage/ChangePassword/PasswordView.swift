//
//  PasswordView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

enum PasswordViewType: String {
    case password = "현재 비밀번호"
    case newPassrod = "새로운 비밀번호"
    case confirmPassword = "비밀번호 확인"
}

class PasswordView: UIView {
    private let type: PasswordViewType
    private let placeholder: String
    
    // 비밀 번호 이미지
    private let imageView = UIImageView().then { view in
        view.image = .lock
    }
    
    // 타이틀
    private lazy var titleLabel = UILabel().then { lbl in
        lbl.text = type.rawValue
        lbl.textColor = UIColor(hex: "592401")
        lbl.font = .ptdMediumFont(ofSize: 16)
    }
    
    // 텍스트 필드
    public lazy var textField = UITextField().then { txt in
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        txt.leftView = leftView
        txt.leftViewMode = .always
        txt.placeholder = placeholder
        txt.font = .ptdRegularFont(ofSize: 14)
        txt.layer.cornerRadius = 6
        txt.layer.borderColor = UIColor(hex: "592401")?.cgColor
        txt.layer.borderWidth = 0.7
    }
    
    init(type: PasswordViewType) {
        self.type = type
        switch type {
        case .password:
            self.placeholder = "현재 비밀번호를 입력해주세요."
        case .newPassrod:
            self.placeholder = "영문/숫자/특수문자 포함 8~20자로 입력해주세요."
        case .confirmPassword:
            self.placeholder = "비밀번호를 한 번 더 입력해주세요."
        }
        super.init(frame: .zero)
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            imageView,
            titleLabel,
            textField
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(4)
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(3)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(11)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(DynamicPadding.dynamicValue(52))
        }
    }
}
