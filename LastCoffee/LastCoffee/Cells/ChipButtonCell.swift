//
//  ChipButton.swift
//  LastCoffee
//
//  Created by 주민영 on 2/23/25.
//

import UIKit

class ChipButtonCell: UICollectionViewCell {
    static let identifier = "ChipButtonCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            chipButton.backgroundColor = isSelected ? .subColor : .clear
            chipButton.setTitleColor(isSelected ? .white : .subColor, for: .normal)
            chipButton.layer.borderWidth = isSelected ? 0 : 0.7
        }
    }
    
    lazy var chipButton = UIButton().then {
        $0.layer.cornerRadius = 13
        $0.layer.borderWidth = 0.7
        $0.layer.borderColor = UIColor.subColor.cgColor
        $0.titleLabel?.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.setTitleColor(.subColor, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.isUserInteractionEnabled = false
        $0.contentEdgeInsets = UIEdgeInsets(top: DynamicPadding.dynamicValue(8), left: DynamicPadding.dynamicValue(10), bottom: DynamicPadding.dynamicValue(8), right: DynamicPadding.dynamicValue(10))
    }
    
    private func setupView() {
        addSubview(chipButton)
        
        chipButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func configure(brand: String, tag: Int) {
        chipButton.setTitle(brand, for: .normal)
        chipButton.tag = tag
        chipButton.sizeToFit()
    }
}
