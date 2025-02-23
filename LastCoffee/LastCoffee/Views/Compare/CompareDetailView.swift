//
//  DetailView.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class CompareDetailView: UIView {
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
            $0.textColor = UIColor(hex: "#8E8E8E")
            $0.text = text
            $0.textAlignment = .left
        }
        return label
    }
    
    public lazy var imageView = UIImageView().then {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 6
        $0.layer.shadowOpacity = 0.08
        $0.layer.masksToBounds = false
        $0.contentMode = .scaleAspectFit
    }
    
    public lazy var image = UIImageView().then {
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    public lazy var coffeeName = UILabel().then {
        $0.font = UIFont.ptdMediumFont(ofSize: 16)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = nil
    }
    
    public lazy var nextBtn = CustomButton(
        backgroundColor: UIColor.mainColor!,
        title: "다른 메뉴와 비교하기",
        titleColor: .white,
        radius: 10,
        isEnabled: true
    )
    
    lazy var caffeineLabel = createLabel(text: "카페인 (mg)", alignment: .left)
    lazy var sugarLabel = createLabel(text: "당류(g)", alignment: .left)
    lazy var proteinLabel = createLabel(text: "단백질(g)", alignment: .left)
    lazy var calorieLabel = createLabel(text: "칼로리(kcal)", alignment: .left)
    
    lazy var caffeineValue = createLabel(text: "150", alignment: .right)
    lazy var sugarValue = createLabel(text: "0", alignment: .right)
    lazy var proteinValue = createLabel(text: "1", alignment: .right)
    lazy var calorieValue = createLabel(text: "10", alignment: .right)
    
    lazy var labelStack = UIStackView(arrangedSubviews: [caffeineLabel, sugarLabel, proteinLabel, calorieLabel]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 10
    }
    
    lazy var valueStack = UIStackView(arrangedSubviews: [caffeineValue, sugarValue, proteinValue, calorieValue]).then {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 10
    }
    
    // Create a horizontal stack view to arrange text and value stacks
    lazy var mainStack = UIStackView(arrangedSubviews: [labelStack, valueStack]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    
    private func setupView() {
        [
            imageView,
            coffeeName,
            mainStack,
            nextBtn
        ].forEach {
            addSubview($0)
        }
        
        imageView.addSubview(image)
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(28)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(280)
            $0.height.equalTo(285)
        }
        
        image.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(280)
            $0.height.equalTo(285)
        }
        
        coffeeName.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
        }
        
        mainStack.snp.makeConstraints {
            $0.top.equalTo(coffeeName.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(41)
            $0.trailing.equalToSuperview().offset(-41)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(mainStack.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(100)
            make.height.equalTo(55)
        }
        
    }
}

