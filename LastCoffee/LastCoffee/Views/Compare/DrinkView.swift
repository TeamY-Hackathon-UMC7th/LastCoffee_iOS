//
//  DrinkView.swift
//  LastCoffee
//
//  Created by 김도연 on 1/13/25.
//

import UIKit

class DrinkView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var shadowView = UIImageView().then {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
        $0.layer.shadowOpacity = 0.08
    }
    
    public lazy var imageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }

    public lazy var coffeeName = UILabel().then {
        $0.font = UIFont.ptdMediumFont(ofSize: 12)
        $0.textColor = UIColor(hex: "5D5D5D")
        $0.textAlignment = .center
        $0.numberOfLines = 3
    }
    
    func setCoffeeName(_ name: String) {
        coffeeName.text = name
    }
    
    func setGoodCoffeeNameColor() {
        coffeeName.textColor = UIColor(hex: "994E24")
    }
    
    func setDrinkInfo(image : String, brand: String, name : String) {
        self.imageView.sd_setImage(with: URL(string: image))
        let resultString = "[" + brand + "]\n" + name
        setCoffeeName(resultString)
    }
    
    private func setupView() {
        [
            shadowView,
            coffeeName,
        ].forEach {
            addSubview($0)
        }
        shadowView.addSubview(imageView)
        
        shadowView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        coffeeName.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

