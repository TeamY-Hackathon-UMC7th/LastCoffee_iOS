//
//  NoteDetailView.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var shadowView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.08
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 6
        $0.layer.masksToBounds = false
    }
    
    public lazy var imageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.contentMode = .scaleAspectFit
    }
    
    public lazy var coffeeName = UILabel().then {
        $0.font = UIFont.ptdMediumFont(ofSize: 16)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = nil
    }
    
    public lazy var drinking = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .left
        
        $0.text = "마신 일시 | 2024년 7월 8일 오후 5시"
    }
    
    public lazy var sleeping = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .left
        
        $0.text = "취침 시간 | 2024년 7월 9일 오전 2시"
    }
    
    private lazy var review = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .left
        
        $0.text = "후기"
    }
    
    public lazy var reviewContents = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor.black
        $0.textAlignment = .left
        
        $0.text = "하루 두잔이나 마셨지만 이전보다 빨리 먹으니까 확실히 잠이 잘 오는 것 같다."
    }
    
    public lazy var createdAt = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .left
        
        $0.text = "2024년 7월 8일 오전 2시"
    }
    
    private func setupView() {
        [
            shadowView,
            coffeeName,
            drinking,
            sleeping,
            review,
            reviewContents,
            createdAt
        ].forEach {
            addSubview($0)
        }
        
        shadowView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(45)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(262)
            $0.height.equalTo(267)
        }
        
        shadowView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        coffeeName.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
        }
        
        drinking.snp.makeConstraints {
            $0.top.equalTo(coffeeName.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(44)
        }
        
        sleeping.snp.makeConstraints {
            $0.top.equalTo(drinking.snp.bottom).offset(12)
            $0.leading.equalTo(drinking.snp.leading)
        }
        
        review.snp.makeConstraints {
            $0.top.equalTo(sleeping.snp.bottom).offset(20)
            $0.leading.equalTo(drinking.snp.leading)
        }
        
        reviewContents.snp.makeConstraints {
            $0.top.equalTo(review.snp.bottom).offset(5)
            $0.leading.equalTo(drinking.snp.leading)
        }
        
        createdAt.snp.makeConstraints {
            $0.top.equalTo(reviewContents.snp.bottom).offset(30)
            $0.leading.equalTo(reviewContents.snp.leading)
        }
    }
}

