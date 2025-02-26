//
//  ChangePasswordView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class ChangePasswordView: UIView {
    private let stackView = UIStackView().then { view in
        view.axis = .vertical
        view.spacing = 40
        view.distribution = .fillEqually
    }
    
    // 현재 비밀번호
    public let passwordView = PasswordView(type: .password)
    
    // 새로운 비밀번호
    public let newPasswordView = PasswordView(type: .newPassrod)
    
    // 비밀번호 확인
    public let confirmPasswordView = PasswordView(type: .confirmPassword)
    
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
            stackView,
            confirmButton
        ].forEach{self.addSubview($0)}
            
        [
            passwordView,
            newPasswordView,
            confirmPasswordView
        ].forEach{stackView.addArrangedSubview($0)}
    }
    
    private func setUI() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(DynamicPadding.dynamicValue(50))
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(DynamicPadding.dynamicValue(338))
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(DynamicPadding.dynamicValue(76))
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(DynamicPadding.dynamicValue(52))
        }
    }
}
