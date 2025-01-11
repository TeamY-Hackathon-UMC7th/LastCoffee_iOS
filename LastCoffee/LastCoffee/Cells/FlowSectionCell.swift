//
//  FlowSectionCell.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit
import SDWebImage

class FlowSectionCell: UICollectionViewCell {
    static let id = "FlowSectionCell"
    
    private let imageView = UIImageView().then { view in
        
    }
    
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .ptdRegularFont(ofSize: 12)
        lbl.tintColor = UIColor(hex: "2C2C2C")
        lbl.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            imageView,
            lblTitle
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        imageView.snp.makeConstraints { make in
            make.width.equalTo(66)
            make.height.equalTo(82)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    public func config(title: String, imageURL: String) {
        lblTitle.text = title
        imageView.sd_setImage(with: URL(string: imageURL))
    }
}

