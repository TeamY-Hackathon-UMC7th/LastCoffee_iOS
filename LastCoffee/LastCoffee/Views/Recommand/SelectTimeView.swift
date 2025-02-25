//
//  SelectTimeView.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

enum SelectTimeType {
    case inRecommend
    case inAlert
}


class SelectTimeView: UIView {
    private let type: SelectTimeType
    
    // 타이틀
    private lazy var lblTitle = UILabel().then { lbl in
        switch type {
        case .inRecommend:
            lbl.text = "오늘 몇 시에 주무실 예정인가요?"
        case .inAlert:
            lbl.text = "커피 추천 알림을 언제 보내드릴까요?"
        }
        lbl.font = .ptdSemiBoldFont(ofSize: 18)
        lbl.textAlignment = .center
    }
    
    // 시간 선택 그룹
    private let grpSelectTime = UIView().then { view in
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.mainColor.cgColor
        view.layer.borderWidth = 0.7
    }
    
    // 달 이미지뷰
    private lazy var imageView = UIImageView().then { view in
        view.image = .moon
        view.tintColor = .mainColor
        view.isHidden = type == .inAlert
    }
    
    // 시간 선택 피커
    public let timePickerView = UIPickerView()
    
    // -시
    private let lblTime = UILabel().then { lbl in
        lbl.text = "시"
        lbl.textColor = .mainColor
        lbl.font = .ptdMediumFont(ofSize: 18)
    }
    
    // 다음 버튼
    public lazy var btnNext = CustomButton().then { btn in
        btn.configure(title: type == .inAlert ? "확인" : "다음", titleColor: .white, font: .ptdSemiBoldFont(ofSize: 18), radius: 10, backgroundColor: UIColor(hex: "592401") ?? .mainColor, isEnabled: true)
    }
    
    init(type: SelectTimeType) {
        self.type = type
        super.init(frame: .zero)
        
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
            timePickerView,
            lblTime
        ].forEach{grpSelectTime.addSubview($0)}
        
        [
            lblTitle,
            grpSelectTime,
            btnNext
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        // "오늘 몇 시에 주무실 건가요" 라벨
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(32)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        grpSelectTime.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(90)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(44)
        }
        
        // 피커
        timePickerView.snp.makeConstraints { make in
            make.width.equalTo(153)
            make.center.equalToSuperview()
        }
        
        // 달 모양 이미지뷰
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        // -시
        lblTime.snp.makeConstraints { make in
            make.leading.equalTo(timePickerView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        // 다음 버튼
        btnNext.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(76)
            make.height.equalTo(52)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}

