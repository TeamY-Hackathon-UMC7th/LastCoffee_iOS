//
//  HelpView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/27/25.
//

import UIKit


class HelpView: UIView {
    private let type: HelpViewType
    private let scrollView = UIScrollView().then { view in
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
    }
    
    private lazy var contentLabel = UILabel().then { lbl in
        lbl.text = type.content
        lbl.font = .ptdRegularFont(ofSize: 14)
        lbl.textColor = UIColor(hex: "2C2C2C")
        lbl.numberOfLines = 0
    }
    
    init(type: HelpViewType) {
        self.type = type
        super.init(frame: .zero)
    
        self.backgroundColor = .background
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        self.addSubview(scrollView)
        scrollView.addSubview(contentLabel)
    }
    
    private func setUI(){
        scrollView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
