//
//  PopularBannerSectionCell.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

class PopularBannerSectionCell: UICollectionViewCell {
    static let id = "BannerSectionCell"
    
    private let imageView = UIImageView().then { view in
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    private let grpInfo = UIView()
    
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .ptdMediumFont(ofSize: 14)
        lbl.tintColor = .mainColor
    }
    
    private let lblCafeine = InfoView(title: "카페인 (mg)")
    private let lblSugar = InfoView(title: "당류 (g)")
    private let lblCalorie = InfoView(title: "칼로리 (kcal)")
    private let lblProtein = InfoView(title: "단백질 (g)")
    
    private let infoStackView = UIStackView().then { view in
        view.axis = .vertical
        view.spacing = 12
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        
        setSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            lblCafeine,
            lblSugar,
            lblProtein,
            lblCalorie,
        ].forEach{infoStackView.addArrangedSubview($0)}
        
        [
            lblTitle,
            infoStackView
        ].forEach{grpInfo.addSubview($0)}
        
        [
            imageView,
            grpInfo
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        imageView.snp.makeConstraints { make in
            make.width.equalTo(158)
            make.height.equalTo(163)
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        grpInfo.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(19)
            make.top.equalTo(imageView).inset(17)
            make.trailing.equalToSuperview().inset(22)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(imageView).inset(8)
        }
    }
    
    public func config(title: String, imageURL: String, cafeine: String, sugar: String, calorie: String, protein: String) {
        lblTitle.text = title
        imageView.sd_setImage(with: URL(string: imageURL))
        
        lblCafeine.config(value: cafeine)
        lblSugar.config(value: sugar)
        lblCalorie.config(value: calorie)
        lblProtein.config(value: protein)
    }
}

