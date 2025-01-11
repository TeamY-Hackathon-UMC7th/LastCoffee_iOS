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
    
    public lazy var totalBtn = makeBtn(title: "전체", tagNum: 1)
    public lazy var starbucksBtn = makeBtn(title: "스타벅스", tagNum: 2)
    public lazy var composeBtn = makeBtn(title: "컴포즈커피", tagNum: 3)
    
    private lazy var btnStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .leading
        $0.spacing = 6
    }
    
    public lazy var noteSearchTableView = UITableView().then {
        $0.register(NoteSearchCell.self, forCellReuseIdentifier: NoteSearchCell.identifier)
        $0.separatorStyle = .singleLine
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = false
    }
    
    private lazy var emptyLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .center
        $0.text = "해당하는 음료가 없어요."
        $0.isHidden = true
    }
    
    private func setupView() {
        btnStackView.addArrangedSubview(totalBtn)
        btnStackView.addArrangedSubview(starbucksBtn)
        btnStackView.addArrangedSubview(composeBtn)
        
        [
            searchBar,
            btnStackView,
            noteSearchTableView,
            emptyLabel
        ].forEach {
            addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(35)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(343)
            $0.height.equalTo(48)
        }
        
        btnStackView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-160)
            $0.height.equalTo(30)
        }
        
        noteSearchTableView.snp.makeConstraints {
            $0.top.equalTo(btnStackView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(184)
            $0.leading.equalToSuperview().offset(112)
            $0.trailing.equalToSuperview().offset(-122)
        }
    }

    func makeBtn(title: String, tagNum: Int) -> UIButton{
        let btn = UIButton().then {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(UIColor(hex: "#767676"), for: .normal)
            $0.titleLabel?.font = UIFont.ptdRegularFont(ofSize: 14)
            $0.backgroundColor = UIColor(hex: "#FFF9F4")
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = UIColor(hex: "#8C8C8C")?.cgColor
            $0.layer.borderWidth = 0.7
            $0.tag = tagNum
            $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        }
        
        return btn
    }
}


