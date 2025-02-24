//
//  AccountInfoView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit

class AccountInfoView: UIView {
    
    // 편지 이미지
    private let imageView = UIImageView().then { view in
        view.image = UIImage(named: "mail")
        view.tintColor = .mainColor
    }
    
    // 이메일라벨
    private let emailLabel = UILabel().then { lbl in
        lbl.text = "{email@example.com}"
        lbl.font = .ptdRegularFont(ofSize: 16)
        lbl.textColor = UIColor(hex: "2C2C2C")
    }
    
    // 분리선
    private let seperatorLine = UIView().then { view in
        view.backgroundColor = UIColor(hex: "D9D9D9")
    }
    
    // 비밀번호 변경
    public let changePasswordButton = UIButton().then { btn in
        btn.setTitle("비밀번호 변경", for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.titleLabel?.font = .ptdRegularFont(ofSize: 14)
        btn.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
    }
    
    // 로그아웃
    public let logoutButton = UIButton().then { btn in
        btn.setTitle("로그아웃", for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.titleLabel?.font = .ptdRegularFont(ofSize: 14)
        btn.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
    }
    
    // 회원 탈퇴
    public let withdrawButton = UIButton().then { btn in
        btn.setTitle("회원 탈퇴", for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.titleLabel?.font = .ptdRegularFont(ofSize: 14)
        btn.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
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
    
    private func setSubView() {
        [
            imageView,
            emailLabel,
            seperatorLine,
            changePasswordButton,
            logoutButton,
            withdrawButton
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(18)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(16)
        }
        
        seperatorLine.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(0.7)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(seperatorLine.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(25)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(25)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(25)
        }
    }
}
