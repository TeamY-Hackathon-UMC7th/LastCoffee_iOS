//
//  RecordInfoView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit


enum RecordInfoType: String {
    case coffeeRecord = "커피 기록"
    case recommendRecord = "추천 내역"
}
class RecordInfoView: UIView {
    private let type: RecordInfoType
    
    // 타이틀
    private lazy var titleLabel = UILabel().then { lbl in
        lbl.text = type.rawValue
        lbl.font = .ptdRegularFont(ofSize: 12)
        lbl.textColor = .black
    }
    
    // 정보 라벨
    private lazy var infoLabel = UILabel().then { lbl in
        lbl.text = type == .coffeeRecord ? "00건" : "확인하기"
        lbl.font = .ptdSemiBoldFont(ofSize: 16)
        lbl.textColor = .black
    }
    
    // 화살표 이미지
    private lazy var arrowImageView = UIImageView().then { view in
        view.isHidden = type == .coffeeRecord // 커피 기록일 때는 숨김
        view.image = UIImage(systemName: "chevron.forward")
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
    }
    
    // 이미지뷰
    private lazy var imageView = UIImageView().then { view in
        view.image = type == .coffeeRecord ? .coffee : .coffeeBeanEmpty
        view.tintColor = UIColor(hex: "592401")
        view.contentMode = .scaleAspectFit
    }
    
    init(type: RecordInfoType) {
        self.type = type
        super.init(frame: .zero)
        self.backgroundColor = UIColor(hex: "F9F1E9")
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hex: "F9F3ED")?.cgColor
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            titleLabel,
            infoLabel,
            arrowImageView,
            imageView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(titleLabel)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(infoLabel)
            make.leading.equalTo(infoLabel.snp.trailing)
            make.width.height.equalTo(20)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
            make.width.height.equalTo(24)
        }
    }
}
