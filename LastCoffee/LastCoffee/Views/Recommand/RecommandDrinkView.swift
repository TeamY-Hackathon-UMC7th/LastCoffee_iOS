//
//  RecommendDrinkView.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

class RecommendDrinkView: UIView {
    private let selectedHour : String

    private lazy var lblTitle = UILabel().then { lbl in
        lbl.font = .ptdSemiBoldFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        
        let text = "\(selectedHour) 시에 잠드려면\n마셔도 괜찮은 음료예요!"
        
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor(hex: "EE633A") ?? .orange, range: (text as NSString).range(of: "\(selectedHour) 시"))
        lbl.attributedText = attributedText
    }
    
    
    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then { view in
        view.register(RecommendBannerCell.self, forCellWithReuseIdentifier: RecommendBannerCell.id)
    }
    
    public let btnCheck = CustomButton().then { btn in
        btn.configure(title: "확인", titleColor: .white, font: .ptdSemiBoldFont(ofSize: 18), radius: 10, backgroundColor: .mainColor ?? .tintColor, isEnabled: true)
    }
    
    init(selectedHour: String) {
        self.selectedHour = selectedHour
        super.init(frame: .zero)
        self.backgroundColor = .background
        setSubView()
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            lblTitle,
            collectionView,
            btnCheck
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(80)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(46)
        }
        
        btnCheck.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(76)
            make.height.equalTo(52)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            return self.createBannerSection()
        })
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 14)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(396))
//        let group = NSCollectionLayoutGroup(layoutSize: groupSize, supplementaryItems:)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 45)
        
        return section
    }

}

