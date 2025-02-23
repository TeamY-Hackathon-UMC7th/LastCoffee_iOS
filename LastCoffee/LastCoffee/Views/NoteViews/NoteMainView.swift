//
//  NoteMainView.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit
import SnapKit
import Then

class NoteMainView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var title = UILabel().then {
        $0.font = UIFont.ptdSemiBoldFont(ofSize: 26)
        $0.textColor = .black
        $0.text = "기록"
    }
    
    public lazy var addBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .mainColor
    }
    
    public lazy var noteTableView = UITableView().then {
        $0.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
    
    private func setupView() {
        [
            title,
            addBtn,
            noteTableView
        ].forEach {
            addSubview($0)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addBtn.snp.makeConstraints {
            $0.centerY.equalTo(title.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(28)
        }
        
        noteTableView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(55)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
    }

}
