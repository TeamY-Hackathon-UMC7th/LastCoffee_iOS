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
        view.layer.cornerRadius = 6.1
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
    }
    
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .ptdRegularFont(ofSize: 12)
        lbl.tintColor = UIColor(hex: "2C2C2C")
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.cornerRadius = 10.16
        setSubView()
        setUI()
        configureShadow()
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
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    private func configureShadow() {
        self.layer.shadowColor = UIColor(hex: "82532A")?.withAlphaComponent(0.08).cgColor // 그림자 색상
        self.layer.shadowOpacity = 0.8 // 그림자 투명도 (0.0 ~ 1.0)
        self.layer.shadowOffset = CGSize(width: 0, height: 0) // 그림자의 위치 (x, y)
        self.layer.shadowRadius = 10.16 // 그림자 흐림 정도
        self.layer.masksToBounds = false // 그림자가 보이도록 설정
    }
    
    public func config(title: String, brand: String, imageURL: String) {
        lblTitle.text = "[\(brand)] \(title)"
        imageView.sd_setImage(with: URL(string: imageURL))
    }
}

