//
//  HomeAlertView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/27/25.
//

import UIKit

class HomeAlertView: UIView {
    // 가운데 얼럿 뷰
    private let groupView = UIView().then { view in
        view.backgroundColor = UIColor(hex: "FFFEFB")
        view.layer.cornerRadius = 10
    }
    
    // 닉네임 라벨
    private lazy var nicknameLabel = UILabel().then { lbl in
        lbl.text = "default님"
        lbl.font = .ptdMediumFont(ofSize: 18)
        lbl.textColor = UIColor(hex: "2C2C2C")
    }
    
    // 인사라벨
    private let greetingLabel = UILabel().then { lbl in
        lbl.text = "라스트 커피에 오신 걸 환영합니다!"
        lbl.font = .ptdMediumFont(ofSize: 12)
        lbl.textColor = UIColor(hex: "2C2C2C")
    }
    
    // 시간 변경 버튼
    public let changeTimeButton = UIButton().then { btn in
        btn.setTitle("시간 변경하기", for: .normal)
        btn.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
        btn.titleLabel?.font = .ptdSemiBoldFont(ofSize: 12)
    }

    // 시계 이미지 뷰
    private let clockImageView = UIImageView().then { view in
        view.image = .clock
    }
    
    // 시간 라벨
    private let timeLabel = UILabel().then { lbl in
        lbl.text = "오후 4시"
        lbl.font = .ptdSemiBoldFont(ofSize: 20)
    }
    
    // 알림 라벨
    private let alertLabel = UILabel().then { lbl in
        lbl.text = "커피 추천 알림을 보내드릴까요?"
        lbl.font = .ptdSemiBoldFont(ofSize: 14)
        lbl.textColor = UIColor(hex: "2C2C2C")
    }
    
    // 스택뷰
    private let stackView = UIStackView().then { view in
        view.axis = .horizontal
        view.spacing = DynamicPadding.dynamicValuebyWidth(18)
        view.distribution = .fillEqually
    }
    
    // 아니요 버튼
    public let noButton = AlertButton(type: .no)
    
    // 네 버튼
    public let yesButton = AlertButton(type: .yes)
    
    
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
            nicknameLabel,
            greetingLabel,
            changeTimeButton,
            clockImageView,
            timeLabel,
            alertLabel,
            stackView
        ].forEach{groupView.addSubview($0)}
        
        [
            noButton,
            yesButton
        ].forEach{stackView.addArrangedSubview($0)}
    }
    
    private func setUI() {
        groupView.snp.makeConstraints { make in
            make.width.equalTo(DynamicPadding.dynamicValuebyWidth(290))
            make.height.equalTo(DynamicPadding.dynamicValue(400))
            make.center.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(DynamicPadding.dynamicValue(32))
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(26)
        }
        
        greetingLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(2)
            make.leading.equalTo(nicknameLabel).offset(1)
        }
        
        changeTimeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.height.equalTo(16)
            make.width.equalTo(66)
        }
        
        clockImageView.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom).offset(DynamicPadding.dynamicValue(45))
            make.centerX.equalToSuperview()
            make.width.equalTo(DynamicPadding.dynamicValuebyWidth(98))
            make.height.equalTo(DynamicPadding.dynamicValue(106))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(clockImageView.snp.bottom).offset(DynamicPadding.dynamicValue(16))
            make.height.equalTo(DynamicPadding.dynamicValue(32))
            make.centerX.equalToSuperview()
        }
        
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(DynamicPadding.dynamicValue(26))
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(DynamicPadding.dynamicValue(22))
            make.horizontalEdges.equalToSuperview().inset(19)
            make.height.equalTo(DynamicPadding.dynamicValue(46))
        }
    }
    
    public func setNickname(nickname: String) {
        nicknameLabel.text = "\(nickname)님"
    }
}
