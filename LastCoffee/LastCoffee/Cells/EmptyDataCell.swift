//
//  EmptyDataCell.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

class EmptyDataCell: UICollectionViewCell {
    static let id = "EmptyDataCell"
    
    private let lblTitle = UILabel().then { lbl in
        lbl.text = "아직 추천 받은 메뉴가 없어요"
        lbl.textColor = UIColor(hex: "111111")
        lbl.textAlignment = .center
        lbl.font = .ptdMediumFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lblTitle)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
    }
}
