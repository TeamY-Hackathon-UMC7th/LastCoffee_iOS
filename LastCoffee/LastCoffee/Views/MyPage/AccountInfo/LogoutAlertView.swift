//
//  LogoutAlertView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class LogoutAlertView: UIView {
    // 가운데 얼럿 뷰
    private let groupView = UIView().then { view in
        view.backgroundColor = UIColor(hex: "FFFEFB")
        view.layer.cornerRadius = 10
    }
    
    // 타이틀
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "로그아웃 하시겠습니까?"
        lbl.font = .ptdSemiBoldFont(ofSize: 16)
        lbl.textColor = .black
        lbl.textAlignment = .center
    }
    
    // 스택뷰
    private let stackView = UIStackView().then { view in
        view.axis = .horizontal
        view.spacing = DynamicPadding.dynamicValuebyWidth(20)
        view.distribution = .fillEqually
    }
    
    // 취소 버튼
    public let cancelButton = AccountInfoAlertButton(type: .cancel)
    
    // 확인 버튼
    public let confirmButton = AccountInfoAlertButton(type: .confirm)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        self.addSubview(groupView)
        
        [
            titleLabel,
            stackView
        ].forEach{groupView.addSubview($0)}
        
        [
            cancelButton,
            confirmButton
        ].forEach{stackView.addArrangedSubview($0)}
    }
    
    private func setUI() {
        groupView.snp.makeConstraints { make in
            make.width.equalTo(DynamicPadding.dynamicValuebyWidth(270))
            make.height.equalTo(DynamicPadding.dynamicValue(170))
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(DynamicPadding.dynamicValue(46))
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(19)
            make.height.equalTo(DynamicPadding.dynamicValue(42))
        }
    }
}
