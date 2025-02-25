//
//  NoteSearchView.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteSearchView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var title = UILabel().then {
        $0.font = UIFont.ptdSemiBoldFont(ofSize: 22)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "어떤 커피를 마셨나요?"
    }

    public lazy var searchBar = SearchBar()
    
    public lazy var noteSearchTableView = UITableView().then {
        $0.register(NoteSearchCell.self, forCellReuseIdentifier: NoteSearchCell.identifier)
        $0.separatorStyle = .singleLine
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = false
    }
    
    public lazy var nextBtn = CustomButton(
        backgroundColor: UIColor.mainColor,
        title: "다음으로",
        titleColor: .white,
        radius: 10,
        isEnabled: false
    )
    
    public lazy var emptyLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .center
        $0.text = "해당하는 음료가 없어요."
        $0.isHidden = true
    }
    
    private func setupView() {
        [
            title,
            searchBar,
            noteSearchTableView,
            nextBtn,
            emptyLabel
        ].forEach {
            addSubview($0)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        
        nextBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-76)
            $0.width.equalTo(343)
            $0.height.equalTo(52)
        }
        
        noteSearchTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(nextBtn.snp.top)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(184)
            $0.leading.equalToSuperview().offset(112)
            $0.trailing.equalToSuperview().offset(-122)
        }
    }
}

