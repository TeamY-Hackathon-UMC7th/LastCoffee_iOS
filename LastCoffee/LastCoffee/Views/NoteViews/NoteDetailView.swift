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
    
    // 뷰 업데이트 함수
    func updateNoteDetail(with data: NoteDetailModel) {
        imageView.sd_setImage(with: URL(string: data.coffeeImgUrl))
        coffeeName.text = "[\(data.brand)] \(data.coffeeName)"
        drinking.text = "마신 일시  |  \(extractDateTime(from: data.drinkDate))"
        sleeping.text = "취침 시간  |  \(extractDateTime(from: data.sleepDate))"
        reviewContents.text = data.review
        writeDate.text = extractDateTime(from: data.writeDate)
    }
    
    // 날짜 형식 변환 함수
    func extractDateTime(from dateTimeString: String) -> String {
        let trimmedDate = String(dateTimeString.prefix(16))
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        if let date = inputFormatter.date(from: trimmedDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "ko_KR")
            outputFormatter.dateFormat = "yyyy년 MM월 dd일 a h시"
            return outputFormatter.string(from: date)
        } else {
            return "날짜 형식 없음"
        }
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
        $0.textColor = .mainColor
        $0.textAlignment = .center
        $0.text = nil
    }
    
    public lazy var drinking = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor.neutral300
        $0.textAlignment = .left
        
        $0.text = "마신 일시 | 2024년 7월 8일 오후 5시"
    }
    
    public lazy var sleeping = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor.neutral300
        $0.textAlignment = .left
        
        $0.text = "취침 시간 | 2024년 7월 9일 오전 2시"
    }
    
    private lazy var review = UILabel().then {
        $0.font = UIFont.ptdSemiBoldFont(ofSize: 14)
        $0.textColor = .mainColor
        $0.textAlignment = .left
        
        $0.text = "후기"
    }
    
    public lazy var reviewContents = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor.black
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.lineBreakMode = .byCharWrapping
        
        $0.text = "하루 두잔이나 마셨지만 이전보다 빨리 먹으니까 확실히 잠이 잘 오는 것 같다."
    }
    
    public lazy var writeDate = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor.neutral300
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
            writeDate
        ].forEach {
            addSubview($0)
        }
        
        shadowView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(DynamicPadding.dynamicValue(48))
            $0.centerX.equalToSuperview()
            $0.width.equalTo(DynamicPadding.dynamicValuebyWidth(262))
            $0.height.equalTo(DynamicPadding.dynamicValuebyWidth(267))
        }
        
        shadowView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        coffeeName.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(DynamicPadding.dynamicValue(32))
            $0.centerX.equalToSuperview()
        }
        
        drinking.snp.makeConstraints {
            $0.top.equalTo(coffeeName.snp.bottom).offset(DynamicPadding.dynamicValue(16))
            $0.leading.equalToSuperview().offset(DynamicPadding.dynamicValue(40))
        }
        
        sleeping.snp.makeConstraints {
            $0.top.equalTo(drinking.snp.bottom).offset(DynamicPadding.dynamicValue(12))
            $0.leading.equalTo(drinking.snp.leading)
        }
        
        review.snp.makeConstraints {
            $0.top.equalTo(sleeping.snp.bottom).offset(DynamicPadding.dynamicValue(32))
            $0.leading.equalTo(drinking.snp.leading)
        }
        
        reviewContents.snp.makeConstraints {
            $0.top.equalTo(review.snp.bottom).offset(DynamicPadding.dynamicValue(4))
            $0.leading.trailing.equalToSuperview().inset(DynamicPadding.dynamicValue(40))
            $0.height.lessThanOrEqualTo(DynamicPadding.dynamicValuebyWidth(120))
        }
        
        writeDate.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(DynamicPadding.dynamicValue(32))
            $0.leading.equalTo(reviewContents.snp.leading)
        }
    }
}

