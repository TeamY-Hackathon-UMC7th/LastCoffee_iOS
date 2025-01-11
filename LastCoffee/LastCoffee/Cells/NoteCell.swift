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
        self.drinkingDate.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    let last = UIView().then {
        $0.backgroundColor = UIColor(hex: "#EE633A")
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
        $0.image = UIImage()
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
    }
    
    private lazy var title = UILabel().then {
        $0.font = UIFont.ptdMediumFont(ofSize: 16)
        $0.textColor = .black
    }
    
    private lazy var subTitle = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = UIColor(hex: "#8E8E8E")
    }
    
    private lazy var titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 8
    }
    
    private lazy var drinkingDate = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.textColor = UIColor(hex: "#8E8E8E")
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        titleStackView.addArrangedSubview(title)
        titleStackView.addArrangedSubview(subTitle)
        
        [
            last,
            image,
            titleStackView,
            drinkingDate
        ].forEach {
            containerView.addSubview($0)
        }
        
        last.addSubview(lastLabel)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 4
        contentView.layer.masksToBounds = false
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
        }
        
        last.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.equalTo(66)
            $0.height.equalTo(18)
        }
        
        image.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        lastLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            $0.centerY.equalTo(image.snp.centerY)
            $0.leading.equalTo(image.snp.trailing).offset(18)
        }
        
        drinkingDate.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        image.snp.makeConstraints {
            $0.width.equalTo(46)
            $0.height.equalTo(50)
        }
    }
    
    public func configure(model: NoteModel) {
        let drinkDate = extractDate(from: model.drinkDate)
        let drinkTime = extractTime(from: model.drinkDate)
        let sleepTime = extractTime(from: model.sleepDate)
        
        self.title.text = model.coffeeName
        self.subTitle.text = "\(drinkTime) 마심 | \(sleepTime) 취침"
        self.drinkingDate.text = drinkDate
    }
    
    func extractDate(from dateTimeString: String) -> String {
        if let range = dateTimeString.range(of: "\\d{4}-\\d{2}-\\d{2}", options: .regularExpression) {
            return String(dateTimeString[range])
        } else {
            return "날짜 형식 없음"
        }
    }
    
    func extractTime(from dateTimeString: String) -> String {
        if let range = dateTimeString.range(of: "\\d{2}:\\d{2}", options: .regularExpression) {
            return String(dateTimeString[range])
        } else {
            return "시간 형식 없음"
        }
    }
}

