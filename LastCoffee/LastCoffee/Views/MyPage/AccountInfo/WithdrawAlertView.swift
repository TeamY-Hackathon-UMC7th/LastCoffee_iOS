//
//  WithdrawAlertView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class WithdrawAlertView: UIView {
    // 가운데 얼럿 뷰
    private let groupView = UIView().then { view in
        view.backgroundColor = UIColor(hex: "FFFEFB")
        view.layer.cornerRadius = 10
    }
    
    // 타이틀
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "정말 탈퇴하시겠습니까?"
        lbl.font = .ptdSemiBoldFont(ofSize: 16)
        lbl.textColor = .black
        lbl.textAlignment = .center
    }
    
    // descriptionLabel
    private let descriptionLabel = UILabel().then { lbl in
        lbl.text = "탈퇴 버튼 선택 시, 계정은\n삭제되며 복구되지 않습니다."
        lbl.numberOfLines = 2
        lbl.font = .ptdMediumFont(ofSize: 12)
        lbl.textColor = UIColor(hex: "2C2C2C")
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
    
    // 탈퇴 버튼
    public let withdrawButton = AccountInfoAlertButton(type: .withdraw)
    
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
            descriptionLabel,
            stackView
        ].forEach{groupView.addSubview($0)}
        
        [
            cancelButton,
            withdrawButton
        ].forEach{stackView.addArrangedSubview($0)}
    }
    
    private func setUI() {
        groupView.snp.makeConstraints { make in
            make.width.equalTo(DynamicPadding.dynamicValuebyWidth(270))
            make.height.equalTo(DynamicPadding.dynamicValue(170))
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DynamicPadding.dynamicValue(26))
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DynamicPadding.dynamicValue(8))
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(DynamicPadding.dynamicValue(20))
            make.horizontalEdges.equalToSuperview().inset(19)
            make.height.equalTo(DynamicPadding.dynamicValue(42))
        }
    }
}
