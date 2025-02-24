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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .background
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
