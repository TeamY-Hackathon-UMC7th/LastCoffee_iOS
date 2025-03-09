//
//  RecommendRecordView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit

class RecommendRecordView: UIView {
    public let tableView = UITableView().then { view in
        view.register(RecommendRecordCell.self, forCellReuseIdentifier: RecommendRecordCell.id)
        
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.selectionFollowsFocus = false
    }
    
    // 추천 기록이 없으면 띄울 이미지
    private let imageView = UIImageView().then { view in
        view.image = .x
//        view.isHidden = true
    }
    
    // 추천 기록이 없으면 띄울 라벨
    private let titleLabel = UILabel().then { lbl in
        lbl.text = "추천 받은 음료가 없습니다."
        lbl.font = .ptdMediumFont(ofSize: 16)
//        lbl.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .background
        setSubView()
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            tableView,
            imageView,
            titleLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    public func setComponent(isNilData: Bool){
        tableView.isHidden = isNilData
        imageView.isHidden = !isNilData
        titleLabel.isHidden = !isNilData
    }
}
