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
    
    public lazy var brandCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 6
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.allowsMultipleSelection = true
        $0.showsHorizontalScrollIndicator = false
        $0.register(ChipButtonCell.self, forCellWithReuseIdentifier: ChipButtonCell.identifier)
    }
    
    public lazy var noteSearchTableView = UITableView().then {
        $0.register(NoteSearchCell.self, forCellReuseIdentifier: NoteSearchCell.identifier)
        $0.separatorStyle = .singleLine
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = false
    }
    
    public lazy var emptyLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = UIColor(hex: "#8E8E8E")
        $0.textAlignment = .center
        $0.text = "해당하는 음료가 없어요."
        $0.isHidden = true
    }
    
    private func setupView() {
        [
            searchBar,
            brandCollectionView,
            noteSearchTableView,
            emptyLabel
        ].forEach {
            addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(35)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        
        brandCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        noteSearchTableView.snp.makeConstraints {
            $0.top.equalTo(brandCollectionView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(184)
            $0.leading.equalToSuperview().offset(112)
            $0.trailing.equalToSuperview().offset(-122)
        }
    }
}




