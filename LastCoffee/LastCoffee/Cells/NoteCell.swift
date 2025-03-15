//
//  NoteCell.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteCell: UITableViewCell {
    static let identifier = "NoteCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = nil
        self.subTitle.text = nil
        self.writeDate.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 6
        $0.layer.masksToBounds = true
    }
    
    let last = UIView().then {
        $0.backgroundColor = .subColor
        $0.layer.cornerRadius = 4
        $0.layer.maskedCorners = [.layerMinXMaxYCorner]
        $0.isHidden = true
    }
    
    let lastLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.ptdSemiBoldFont(ofSize: 10)
        $0.text = "라스트 커피"
    }
    
    private lazy var image = UIImageView().then {
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
    }
    
    private lazy var title = UILabel().then {
        $0.font = UIFont.ptdMediumFont(ofSize: 16)
        $0.numberOfLines = 2
        $0.textColor = .black
    }
    
    private lazy var subTitle = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor.neutral300
    }
    
    private lazy var titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = DynamicPadding.dynamicValue(8)
    }
    
    private lazy var writeDate = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.textColor = UIColor.neutral300
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        titleStackView.addArrangedSubview(title)
        titleStackView.addArrangedSubview(subTitle)
        
        [
            last,
            image,
            titleStackView,
            writeDate
        ].forEach {
            containerView.addSubview($0)
        }
        
        last.addSubview(lastLabel)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.masksToBounds = false
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: DynamicPadding.dynamicValue(8), right: 0))
            $0.height.equalTo(DynamicPadding.dynamicValue(80))
        }
        
        last.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.equalTo(DynamicPadding.dynamicValuebyWidth(66))
            $0.height.equalTo(DynamicPadding.dynamicValuebyWidth(18))
        }
        
        image.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(DynamicPadding.dynamicValue(16))
            $0.centerY.equalToSuperview()
            $0.width.equalTo(DynamicPadding.dynamicValuebyWidth(52))
            $0.height.equalTo(DynamicPadding.dynamicValuebyWidth(53))
        }
        
        lastLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            $0.centerY.equalTo(image.snp.centerY)
            $0.leading.equalTo(image.snp.trailing).offset(DynamicPadding.dynamicValue(16))
            $0.trailing.equalToSuperview().inset(DynamicPadding.dynamicValue(56))
        }
        
        writeDate.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(DynamicPadding.dynamicValue(12))
            $0.bottom.equalToSuperview().inset(DynamicPadding.dynamicValue(8))
        }
    }
    
    public func configure(model: NoteModel) {
        let writeDate = extractData(from: model.writeDate)
        
        self.image.sd_setImage(with: URL(string: model.coffeeImgUrl))
        self.title.text = "[\(model.brand)] \(model.coffeeName)"
        self.subTitle.text = "\(model.drinkHour)시 마심 | \(model.sleepHour)시 취침"
        self.writeDate.text = writeDate
    }
    
    // 날짜 형식 변환 함수
    func extractData(from dateTimeString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateTimeString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy.MM.dd"
            return outputFormatter.string(from: date)
        } else {
            return "추출할 데이터가 없습니다."
        }
    }
}

