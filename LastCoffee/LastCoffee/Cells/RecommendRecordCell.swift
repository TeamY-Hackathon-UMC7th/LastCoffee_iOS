//
//  RecommendRecordCell.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit

class RecommendRecordCell: UITableViewCell {
    static let id = "RecommendRecordCell"
    
    private let drinkImageView = UIImageView().then { view in
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
    }
    
    
    // title
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "[brand] title"
        lbl.font = .ptdMediumFont(ofSize: 14)
    }
    
    // 날짜
    private let dateLabel =  UILabel().then { lbl in
        lbl.text = "{2024.12.12}"
        lbl.font = .ptdMediumFont(ofSize: 14)
        lbl.textColor = UIColor(hex: "8E8E8E")
    }
    
    // 분리선
    private let seperatorLine = UIView().then { view in
        view.backgroundColor = .separator
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        drinkImageView.image = nil
        titleLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setSubView() {
        [
            drinkImageView,
            titleLabel,
            dateLabel,
            seperatorLine
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        drinkImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(drinkImageView).offset(9)
            make.leading.equalTo(drinkImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(drinkImageView).offset(-9)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview()
        }
        
        seperatorLine.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(0.7)
        }
    }
}
