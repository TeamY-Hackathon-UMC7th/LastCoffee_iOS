//
//  RecommendBannerCell.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import UIKit


class RecommendBannerCell: UICollectionViewCell {
    static let id = "RecommendBannerCell"
    
    private let imageView = UIImageView().then { view in
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .ptdMediumFont(ofSize: 14)
        lbl.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
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
            make.width.equalTo(240)
            make.height.equalTo(256)
            make.top.equalTo(safeAreaLayoutGuide).inset(47)
            make.centerX.equalToSuperview()
        }
        
        lblTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(34)
        }
    }
    
    private func configureShadow() {
        self.layer.shadowColor = UIColor(hex: "82532A")?.withAlphaComponent(0.08).cgColor // 그림자 색상
        self.layer.shadowOpacity = 0.8 // 그림자 투명도 (0.0 ~ 1.0)
        self.layer.shadowOffset = CGSize(width: 0, height: 0) // 그림자의 위치 (x, y)
        self.layer.shadowRadius = 10.16 // 그림자 흐림 정도
        self.layer.masksToBounds = false // 그림자가 보이도록 설정
    }
    
    public func config(title: String, brand: String, imageURL: String){
        imageView.sd_setImage(with: URL(string: imageURL))
        lblTitle.text = "[\(brand)] \(title)"
        
    }
}
