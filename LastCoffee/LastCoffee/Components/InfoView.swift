//
//  InfoView.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

class InfoView: UIView {
    private let title: String
    
    private lazy var lblCafeien = UILabel().then { lbl in
        lbl.text = title
        lbl.font = .ptdRegularFont(ofSize: 10)
        lbl.tintColor = UIColor(hex: "2C2C2C")
    }
    
    public let lblNum = UILabel().then { lbl in
        lbl.font = .ptdRegularFont(ofSize: 10)
        lbl.tintColor = UIColor(hex: "2C2C2C")
        lbl.textAlignment = .right
    }
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [ lblCafeien, lblNum ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        lblCafeien.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.trailing.equalTo(lblNum.snp.leading)
        }
        
        lblNum.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    public func config(value: Int) {
        self.lblNum.text = "\(value)"
    }
}

