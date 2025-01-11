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
    
//    // 로고 이미지 뷰
//    private let logoImageView = UIImageView().then { view in
//        view.image = .lastCoffeeText
//    }
    
    // 닉네임 라벨
    private lazy var lblNickname = UILabel().then { lbl in
        lbl.text = "\(nickname)님, 반갑습니다!"
        lbl.font = .ptdSemiBoldFont(ofSize: 18)
        lbl.textAlignment = .left
    }
    
    // 컬렉션 뷰
    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then { view in
        // 셀 등록 (헤더 포함)
        view.register(PopularBannerSectionCell.self, forCellWithReuseIdentifier: PopularBannerSectionCell.id)
        view.register(FlowSectionCell.self, forCellWithReuseIdentifier: FlowSectionCell.id)
        
        // 헤더 등록
        view.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.id)
    }
    
    // '오늘의 취침 시간 버튼'
    public let btnRecommendDrink = CustomButton().then { btn in
        btn.configure(title: "지금, 커피 하잔", titleColor: .white, font: .ptdSemiBoldFont(ofSize: 14), radius: 10, backgroundColor: .mainColor ?? .systemBlue, isEnabled: true)
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
//            logoImageView,
            lblNickname,
            collectionView,
            btnRecommendDrink
        ].forEach{self.addSubview($0)}
    }
    
    // 오토레이아웃 설정
    private func setUI(){

//        logoImageView.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).inset(25.5)
//            make.centerX.equalToSuperview()
//        }
        
        lblNickname.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(18)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(lblNickname.snp.bottom).offset(17)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(btnRecommendDrink.snp.top)
        }
        
        btnRecommendDrink.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(52)
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    // flow 섹션 생성 함수 (추천 메뉴)
    private func createFlowSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(116), heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}

