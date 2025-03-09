//
//  KakaoLoginView.swift
//  LastCoffee
//
//  Created by 김도연 on 3/4/25.
//

import UIKit
import SnapKit
import Then

enum AssetName : String {
    case onboardingLogo = "OnboardingLogo"
    case onboardingImage = "OnboardingImage"
}

final class KakaoLoginView: UIView {
    lazy var logoView = UIImageView().then {
        $0.image = UIImage(named: AssetName.onboardingLogo.rawValue)
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var imageView = UIImageView().then {
        $0.image = UIImage(named: AssetName.onboardingImage.rawValue)
        $0.contentMode = .scaleAspectFit
    }
    
    let descriptionLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .center

        let attributedText = NSAttributedString(
            string: "당신의 편안한 밤을 위해, 오늘 하루의\n마지막 한 잔을 제안해 드릴게요!",
            attributes: [
                .font: UIFont.ptdMediumFont(ofSize: 14),
                .foregroundColor: UIColor.fontGray!,
                .paragraphStyle: paragraphStyle
            ]
        )

        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    public let kakaoBtn = CustomButton(backgroundColor: .kakaoYellow!, title: "카카오로 로그인 하기", titleColor: .neutral900!, font: .ptdSemiBoldFont(ofSize: 16), radius: 6, isEnabled: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [logoView, imageView, descriptionLabel, kakaoBtn].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DynamicPadding.dynamicValue(60.0))
            make.centerX.equalToSuperview()
            make.width.equalTo(DynamicPadding.dynamicValuebyWidth(150))
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(DynamicPadding.dynamicValue(96.0))
            make.centerX.equalToSuperview()
            make.width.equalTo(DynamicPadding.superViewHeight * 0.33)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(DynamicPadding.dynamicValue(25.0))
            make.centerX.equalToSuperview()
        }
        
        kakaoBtn.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(DynamicPadding.dynamicValue(100.0))
            make.leading.trailing.equalToSuperview().inset(DynamicPadding.dynamicValue(16.0))
            make.height.equalTo(DynamicPadding.dynamicValue(52.0))
        }
    }
}
