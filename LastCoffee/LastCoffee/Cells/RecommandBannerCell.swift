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
    }
    
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .ptdMediumFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    public func config(title: String, imageURL: String){
        imageView.sd_setImage(with: URL(string: imageURL))
        lblTitle.text = title
        
    }
}
