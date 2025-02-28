//
//  ComponentCell.swift
//  LastCoffee
//
//  Created by 김도연 on 1/13/25.
//

import UIKit
import SnapKit

class ComponentCell: UITableViewCell {
    
    public lazy var componentView: ComponentView = {
        let view = ComponentView()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(coffee1Name: String, coffee2Name: String,
                          componentName: String, unit: String,
                          coffee1: Int, coffee2: Int) {
        componentView.setDrinkDetail(f: "\(coffee1)", s: "\(coffee2)")
        componentView.setLabelText(componentName: componentName, componentUnit: unit)
        if coffee1 > coffee2 {
            componentView.setupAttributedText(coffeeName: coffee1Name, result: "가 더 높아요")
            componentView.setHightlight(isSamewithCaffeine: true)
        } else if coffee1 < coffee2 {
            componentView.setupAttributedText(coffeeName: coffee2Name, result: "가 더 높아요")
            componentView.setHightlight(isSamewithCaffeine: false)
        } else {
            componentView.setupAttributedText(coffeeName: "같아요")
            componentView.setHightlight(isSamewithCaffeine: true, isSame: true)
        }
    }
    
    private func setupView() {
        contentView.backgroundColor = .background
        contentView.addSubview(componentView)
        
        componentView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(DynamicPadding.dynamicValuebyWidth(70))
            make.top.equalToSuperview().inset(DynamicPadding.dynamicValue(24))
            make.bottom.equalToSuperview().inset(DynamicPadding.dynamicValue(20))
            make.leading.trailing.equalToSuperview().inset(DynamicPadding.dynamicValue(16))
        }
    }

}
