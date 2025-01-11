//
//  SearchView.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class SearchView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public lazy var searchBar = SearchBar()
    
    public lazy var noteSearchTableView = UITableView().then {
        $0.register(NoteSearchCell.self, forCellReuseIdentifier: NoteSearchCell.identifier)
        $0.separatorStyle = .singleLine
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = false
        $0.isHidden = true
    }
    
    public lazy var emptyLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .center
        $0.text = "해당하는 음료가 없어요."
        $0.isHidden = true
    }
    
    public lazy var initLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .center
        $0.text = "음료를 검색해보세요!"
        $0.isHidden = false
    }
    
    private func setupView() {
        [
            searchBar,
            noteSearchTableView,
            emptyLabel,
            initLabel
        ].forEach {
            addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(35)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        
        noteSearchTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(184)
            $0.leading.equalToSuperview().offset(112)
            $0.trailing.equalToSuperview().offset(-122)
        }
        
        initLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(184)
            $0.leading.equalToSuperview().offset(112)
            $0.trailing.equalToSuperview().offset(-122)
        }
    }
}




