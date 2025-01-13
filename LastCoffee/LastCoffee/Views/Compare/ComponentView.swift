//
//  ComponentView.swift
//  LastCoffee
//
//  Created by 김도연 on 1/13/25.
//

import UIKit

class ComponentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public lazy var titleLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    public lazy var resultLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    // 결과 라벨
    // 스택뷰
    
    public lazy var componentLbl = createLabel(lines: 3)
    public lazy var firstCoffeeLbl = createLabel(lines: 1)
    public lazy var secCoffeeLbl = createLabel(lines: 1)
    

    func setupAttributedText(coffeeName name: String, result: String = "") {
        let fullText = "\(name)\(result)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let nameRange = (fullText as NSString).range(of: name)
        attributedString.addAttributes([
            .foregroundColor: UIColor.mainColor ?? .brown,
            .font: UIFont.ptdSemiBoldFont(ofSize: 14) // Bold 폰트
        ], range: nameRange)
        
        let resultRange = (fullText as NSString).range(of: result)
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.black,
            range: resultRange
        )
        
        // 결과 텍스트 설정
        resultLabel.attributedText = attributedString
    }
    func createLabel(lines: Int = 1) -> UILabel {
        let label = UILabel().then {
            $0.font = UIFont.ptdRegularFont(ofSize: 14)
            $0.textColor = UIColor(hex: "#8E8E8E")
            $0.textAlignment = .left
            $0.numberOfLines = lines
        }
        return label
    }
    
    /// 요소 이름, 단위 설정
    func setLabelText(componentName cName: String, componentUnit unit: String = "g") {
        if cName == "칼로리" {
            titleLabel.text = cName+"는"
        } else {
            titleLabel.text = cName+"은"
        }
        
        if cName == "당" {
            componentLbl.text = "\(cName)류\n(\(unit))"
        } else {
            componentLbl.text = "\(cName)\n(\(unit))"
        }
    }
    
    /// 음료 별 실제 값 설정
    func setDrinkDetail(f: String, s : String) {
        firstCoffeeLbl.text = f
        secCoffeeLbl.text = s
    }
    
    func setHightlight(isSamewithCaffeine: Bool, isSame: Bool = false) {
        if isSamewithCaffeine { // 1번이 더 큰경우
            firstCoffeeLbl.textColor = UIColor(hex: "373737")
            firstCoffeeLbl.font = .ptdMediumFont(ofSize: 14)
        } else { // 2번이 더 큰경우
            secCoffeeLbl.textColor = UIColor(hex: "373737")
            secCoffeeLbl.font = .ptdMediumFont(ofSize: 14)
        }
        if isSame { // 둘 값이 같으면 원상복귀
            firstCoffeeLbl.textColor = UIColor(hex: "#8E8E8E")
            firstCoffeeLbl.font = UIFont.ptdRegularFont(ofSize: 14)
            secCoffeeLbl.textColor = UIColor(hex: "#8E8E8E")
            secCoffeeLbl.font = UIFont.ptdRegularFont(ofSize: 14)
        }
    }
    
    
    lazy var mainStack = UIStackView(arrangedSubviews: [componentLbl, firstCoffeeLbl, secCoffeeLbl]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    private func setupView() {
        [
            titleLabel,
            resultLabel,
            mainStack
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        mainStack.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
        
    }
}

