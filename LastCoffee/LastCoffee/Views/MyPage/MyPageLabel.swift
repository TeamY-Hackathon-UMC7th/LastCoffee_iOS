//
//  MyPageLabel.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit

enum MyPageLabelType: String {
    case accountInfo = "계정 정보"
    case changeNickname = "닉네임 변경"
    case alertSetting = "알림 설정"
    case personalInfo = "개인정보처리방침"
    case serviceInfo = "서비스 이용 약관"
}

class MyPageLabel: UIView {
    private let type: MyPageLabelType
    
    // 타이틀
    private lazy var titleLabel = UILabel().then { lbl in
        lbl.text = type.rawValue
        lbl.font = .ptdSemiBoldFont(ofSize: 16)
        lbl.textColor = UIColor(hex: "2C2C2C")
    }
    
    // arrowButton
    public let button = UIButton().then { btn in
        btn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btn.tintColor = UIColor(hex: "8E8E8E")
    }
    
    init(type: MyPageLabelType) {
        self.type = type
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            titleLabel,
            button
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        titleLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
            make.trailing.equalTo(button.snp.leading)
        }
        
        button.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.width.height.equalTo(18)
        }
    }
}
