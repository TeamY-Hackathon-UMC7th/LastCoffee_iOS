//
//  RecommandDrinkView.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

class RecommandDrinkView: UIView {
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .ptdSemiBoldFont(ofSize: 18)
        lbl.textAlignment = .center
    }
    
    
    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then { view in
//        <#code#>
    }
    
    public let btnCheck = CustomButton().then { btn in
        btn.configure(title: "확인", titleColor: .white, radius: 10, backgroundColor: .mainColor ?? .tintColor, isEnabled: true)
        
        btn.titleLabel?.font = .ptdSemiBoldFont(ofSize: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    public func config(time: String) {
        lblTitle.text = "\(time)시에 잠드려면\n마셔도 괜찮은 음료예요!"
        lblTitle.attributedText = NSAttributedString(string: time, attributes: [
            .foregroundColor: UIColor(hex: "EE633A") ?? .orange
        ])
    }
}

