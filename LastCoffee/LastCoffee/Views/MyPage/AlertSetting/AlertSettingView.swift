//
//  AlertSettingView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class AlertSettingView: UIView {
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "오후 4시 알림"
        lbl.font = .ptdSemiBoldFont(ofSize: 16)
        lbl.textColor = UIColor(hex: "2C2C2C")
    }
    
    public let alertSwitch = SwitchView()
    
    private let seperatorLine = UIView().then { view in
        view.backgroundColor = UIColor(hex: "D9D9D9")
    }
    
    public let changeAlertTimeGroupView = UIView().then { view in
        view.isUserInteractionEnabled = true
    }
    
    private let changeAlertTitleLabel = UILabel().then { lbl in
        lbl.text = "알림 시간 변경하기"
        lbl.textColor = UIColor(hex: "5D5D5D")
        lbl.font = .ptdMediumFont(ofSize: 14)
    }
    
    // arrowButton
    public let button = UIButton().then { btn in
        btn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        btn.tintColor = UIColor(hex: "2C2C2C")
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
            titleLabel,
            alertSwitch,
            seperatorLine,
            changeAlertTimeGroupView
        ].forEach{self.addSubview($0)}
        
        [
            changeAlertTitleLabel,
            button
        ].forEach{changeAlertTimeGroupView.addSubview($0)}
    }
    
    private func setUI() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(DynamicPadding.dynamicValue(26))
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(alertSwitch.snp.leading).offset(-16)
        }
        
        alertSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        seperatorLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(0.7)
        }
        
        changeAlertTimeGroupView.snp.makeConstraints { make in
            make.top.equalTo(seperatorLine.snp.bottom).offset(16.51)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(124)
            make.height.equalTo(16)
        }
        
        changeAlertTitleLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.leading.equalTo(changeAlertTitleLabel.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
    }
}
