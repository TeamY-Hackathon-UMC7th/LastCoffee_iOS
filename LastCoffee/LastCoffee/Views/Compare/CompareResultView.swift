//
//  CompareResultView.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class CompareResultView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabel(text: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel().then {
            $0.font = UIFont.ptdRegularFont(ofSize: 14)
            $0.textColor = UIColor.neutral300
            $0.text = text
            $0.textAlignment = .left
        }
        return label
    }
    
    private lazy var titleLbl = UILabel().then { lbl in
        lbl.text = "🌿 잠을 방해하지 않는 선택"
        lbl.font = .ptdMediumFont(ofSize: 16)
        lbl.textAlignment = .left
    }
    
    private lazy var resultImage = UIImageView().then { img in
        img.tintColor = .mainColor
        img.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    }
    
    public lazy var firstDrink = DrinkView()
    public lazy var secondDrink = DrinkView()
    
    public func setResult(isSame: Bool) {
        if isSame {
            resultImage.image = UIImage(systemName: "equal")
            firstDrink.setGoodCoffeeNameColor()
            secondDrink.setGoodCoffeeNameColor()
        } else {
            resultImage.image = UIImage(systemName: "chevron.right")
            firstDrink.setGoodCoffeeNameColor()
        }
    }
    
    private func setupView() {
        [
            titleLbl,
            resultImage,
            firstDrink,
            secondDrink
        ].forEach {
            addSubview($0)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DynamicPadding.dynamicValue(8))
            make.leading.trailing.equalToSuperview().inset(DynamicPadding.dynamicValue(16))
        }
        
        firstDrink.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(DynamicPadding.dynamicValue(24))
            make.leading.equalToSuperview().offset(DynamicPadding.dynamicValue(40))
            make.width.equalTo(DynamicPadding.dynamicValuebyWidth(110))
            make.bottom.equalToSuperview()
        }
        
        resultImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(firstDrink.snp.centerY)
        }
        
        secondDrink.snp.makeConstraints { make in
            make.top.equalTo(firstDrink.snp.top)
            make.trailing.equalToSuperview().offset(DynamicPadding.dynamicValue(-40))
            make.width.equalTo(DynamicPadding.dynamicValuebyWidth(110))
            make.bottom.equalToSuperview()
        }
        
    }
}

