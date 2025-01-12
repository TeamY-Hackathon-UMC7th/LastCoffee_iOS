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
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
    }
    
    private let grpInfo = UIView()
    
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .ptdMediumFont(ofSize: 14)
        lbl.tintColor = .mainColor
        lbl.numberOfLines = 2
    }
    
    private let lblCafeine = InfoView(title: "카페인 (mg)")
    private let lblSugar = InfoView(title: "당류 (g)")
    private let lblCalorie = InfoView(title: "칼로리 (kcal)")
    private let lblProtein = InfoView(title: "단백질 (g)")
    
    private let infoGrpView = UIView().then { view in

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        setSubView()
        setUI()
        configureShadow()
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
        ].forEach{infoGrpView.addSubview($0)}
        
        [
            lblTitle,
            infoGrpView
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
//            make.top.equalToSuperview().inset(19)
        }
        
        grpInfo.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(19)
            make.top.equalTo(imageView).inset(17)
            make.trailing.equalToSuperview().inset(22)
            make.bottom.equalTo(imageView).inset(7)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        infoGrpView.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(12)
//            make.height.equalTo(92)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        lblCafeine.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(14)
            make.horizontalEdges.equalToSuperview()
        }
        
        lblSugar.snp.makeConstraints { make in
            make.top.equalTo(lblCafeine.snp.bottom).offset(14)
            make.height.equalTo(14)
            make.horizontalEdges.equalToSuperview()
        }
        
        lblProtein.snp.makeConstraints { make in
            make.top.equalTo(lblSugar.snp.bottom).offset(14)
            make.height.equalTo(14)
            make.horizontalEdges.equalToSuperview()
        }
        
        lblCalorie.snp.makeConstraints { make in
            make.top.equalTo(lblProtein.snp.bottom).offset(14)
            make.height.equalTo(14)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func configureShadow() {
        self.layer.shadowColor = UIColor(hex: "82532A")?.withAlphaComponent(0.08).cgColor // 그림자 색상
        self.layer.shadowOpacity = 0.8 // 그림자 투명도 (0.0 ~ 1.0)
        self.layer.shadowOffset = CGSize(width: 0, height: 0) // 그림자의 위치 (x, y)
        self.layer.shadowRadius = 10.16 // 그림자 흐림 정도
        self.layer.masksToBounds = false // 그림자가 보이도록 설정
    }
    
    public func config(title: String, brand: String, imageURL: String, cafeine: Int, sugar: Int, calorie: Int, protein: Int) {
        lblTitle.text = "[\(brand)] \(title)"
        imageView.sd_setImage(with: URL(string: imageURL))
        
        lblCafeine.config(value: cafeine)
        lblSugar.config(value: sugar)
        lblCalorie.config(value: calorie)
        lblProtein.config(value: protein)
    }
}

