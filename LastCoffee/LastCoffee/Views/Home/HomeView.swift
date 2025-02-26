//
//  HomeView.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit
import Then

class HomeView: UIView {
    private let nickname: String
    
    // 닉네임 라벨
    private lazy var lblNickname = UILabel().then { lbl in
        lbl.text = "\(nickname)님, 오늘도 좋은 하루 보내세요 : )"
        lbl.font = .ptdSemiBoldFont(ofSize: 18)
        lbl.textAlignment = .left
    }
    
    // 컬렉션 뷰
    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then { view in
        // 셀 등록 (헤더 포함)
        view.register(PopularBannerSectionCell.self, forCellWithReuseIdentifier: PopularBannerSectionCell.id)
        view.register(FlowSectionCell.self, forCellWithReuseIdentifier: FlowSectionCell.id)
        
        // 헤더 등록
        view.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
        
        view.backgroundColor = .clear
    }
    
    // '오늘의 취침 시간 버튼'
    public let btnRecommendDrink = CustomButton().then { btn in
        btn.configure(title: "지금, 커피 한 잔 추천", titleColor: .white, font: .ptdSemiBoldFont(ofSize: 14), radius: 10, backgroundColor: .mainColor, isEnabled: true)
    }
    
    public let lblEmptyMenu = UILabel().then { lbl in
        lbl.text = "아직 추천 받은 메뉴가 없어요"
        lbl.textColor = UIColor(hex: "111111")
        lbl.textAlignment = .center
        lbl.font = .ptdMediumFont(ofSize: 14)
        lbl.isHidden = true
   }
    
    init(nickname: String) {
        self.nickname = nickname
        super.init(frame: .zero)
        
        self.backgroundColor = .background
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 서브뷰 추가
    private func setSubView() {

        [
            lblNickname,
            collectionView,
            btnRecommendDrink,
            lblEmptyMenu
        ].forEach{self.addSubview($0)}
    }
    
    // 오토레이아웃 설정
    private func setUI(){

        
        lblNickname.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(18)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(lblNickname.snp.bottom).offset(17)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(btnRecommendDrink.snp.top)
        }
        
        lblEmptyMenu.snp.makeConstraints { make in
            make.bottom.equalTo(btnRecommendDrink.snp.top).offset(-81)
            make.centerX.equalToSuperview()
        }
        
        btnRecommendDrink.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(52)
            make.width.equalTo(192)
            make.height.equalTo(54)
            make.centerX.equalToSuperview()
        }
    }
    
    // 레아이웃 provider
    private func createLayout() -> UICollectionViewCompositionalLayout{
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 22
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            switch sectionIndex {
            case 0: // 인기 메뉴
                return self.createBannerSection()
            case 1: // 최근 추천 메뉴
                return self.createFlowSection()
            default:
                return self.createBannerSection()
            }
        }, configuration: config)
    }
    
    // 베너 섹션 생성 함수 (인기 메뉴)
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(DynamicPadding.superViewWidth - 32), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(26))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16)
        
        
        return section
    }
    
    // flow 섹션 생성 함수 (추천 메뉴)
    private func createFlowSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(26))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
}

