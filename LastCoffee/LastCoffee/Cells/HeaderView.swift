//
//  HeaderView.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//


import UIKit
import Then
import SnapKit

class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"
    
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .ptdSemiBoldFont(ofSize: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            lblTitle
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        lblTitle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func config(title: String) {
        self.lblTitle.text = title
    }
}
