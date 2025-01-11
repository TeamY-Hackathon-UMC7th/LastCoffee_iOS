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
    
    private lazy var topStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 264
    }
    
    public lazy var noteTableView = UITableView().then {
        $0.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
    
    private func setupView() {
        topStackView.addArrangedSubview(title)
        topStackView.addArrangedSubview(addBtn)
        
        [
            topStackView,
            noteTableView
        ].forEach {
            addSubview($0)
        }
        
        addBtn.snp.makeConstraints {
            $0.width.height.equalTo(28)
        }
        
        topStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(29)
            $0.centerX.equalToSuperview()
        }
        
        noteTableView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
    }

}
