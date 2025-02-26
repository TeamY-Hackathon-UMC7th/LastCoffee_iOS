//
//  SwitchView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class SwitchView: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51
        let heightRatio = 22 / standardHeight
        let widthRatio = 37 / standardWidth
        self.transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
        
        self.onTintColor = UIColor(hex: "592401")
    }
}
