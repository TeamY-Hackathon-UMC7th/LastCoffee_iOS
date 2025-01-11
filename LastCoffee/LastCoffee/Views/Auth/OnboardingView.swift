//
//  OnboardingVoiew.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit
import SnapKit
import Then

class OnboardingView: UIView {
    
    let timeText = UILabel().then {
        $0.text = "오후 4시"
        $0.font = .ptdSemiBoldFont(ofSize: 18)
        $0.textColor = .brown
        $0.textAlignment = .left
    }
    
    let mainText = UILabel().then {
        $0.text = "라스트 커피가"
        $0.font = .ptdSemiBoldFont(ofSize: 24)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    let underlineView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let subText = UILabel().then {
        $0.text = "오늘의 마지막 한 잔을"
        $0.font = .ptdSemiBoldFont(ofSize: 24)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    let thirdText = UILabel().then {
        $0.text = "추천해드려요!"
        $0.font = .ptdSemiBoldFont(ofSize: 24)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    let despText = UILabel().then {
        $0.numberOfLines = 0
        $0.attributedText = NSAttributedString(
            string: """
                    여러분의 편안한 밤을 위해,
                    잠에 들 시간을 생각하여
                    특별한 한 잔을 제안해 드릴게요
                    """,
            attributes: [
                .paragraphStyle: NSMutableParagraphStyle().then {
                    $0.lineSpacing = 5 // 행간 간격 설정
                    $0.alignment = .left // 텍스트 정렬 (왼쪽 정렬)
                },
                .font: UIFont.ptdMediumFont(ofSize: 16),
                .foregroundColor: UIColor.gray
            ]
        )
    }
    
    lazy var imageView = UIImageView().then {
        $0.image = UIImage(named: "OnboardingImage")
        $0.contentMode = .scaleAspectFit
    }
    
    let checkButton = CustomButton(
        backgroundColor: .brown,
        title: "시작하기",
        titleColor: .white,
        font: .ptdSemiBoldFont(ofSize: 18),
        radius: 10,
        isEnabled: true
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(underlineView) // 먼저 추가 (Z축에서 아래로)
        addSubview(timeText)
        addSubview(mainText) // 텍스트가 위에 올라오게
        addSubview(subText)
        addSubview(thirdText)
        addSubview(despText)
        addSubview(imageView)
        addSubview(checkButton)
    }
    
    private func setupConstraints() {
        timeText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(115)
            make.leading.equalToSuperview().inset(16)
        }
        
        mainText.snp.makeConstraints { make in
            make.top.equalTo(timeText.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(mainText.snp.bottom).inset(13)
            make.leading.equalTo(mainText)
            make.width.equalTo(110) // 고정 길이
            make.height.equalTo(12) // 고정 두께
        }
        
        subText.snp.makeConstraints { make in
            make.top.equalTo(mainText.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        thirdText.snp.makeConstraints { make in
            make.top.equalTo(subText.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        despText.snp.makeConstraints { make in
            make.top.equalTo(thirdText.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(despText.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(ScreenHeight * 0.1)
        }
        
    }
    
}
