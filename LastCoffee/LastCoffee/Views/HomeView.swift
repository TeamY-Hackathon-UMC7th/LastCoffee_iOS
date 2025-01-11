//
//  HomeView.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit
import Then

class HomeView: UIView {
    // 상단 닉네임 + 알림 버튼
    private let grpTopView = UIView()
    
    // 닉네임 라벨
    private let lblNickname = UILabel().then { lbl in
        lbl.font = .ptdBoldFont(ofSize: 14) // 임시
    }
    
    // 알림 버튼
    public let btnAlert = UIButton().then { btn in
        btn.setImage(.init(systemName: "bell"), for: .normal)
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
    public let btnRecommandDrink = CustomButton().then { btn in
        btn.configure(title: "지금, 커피 하잔", titleColor: .white, radius: 10, backgroundColor: .mainColor ?? .systemBlue, isEnabled: true)
        
        btn.titleLabel?.font = .ptdSemiBoldFont(ofSize: 14)
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
    
    // 서브뷰 추가
    private func setSubView() {
        [
            lblNickname,
            btnAlert
        ].forEach{grpTopView.addSubview($0)}
        

        [
            grpTopView,
            collectionView,
            btnRecommandDrink
        ].forEach{self.addSubview($0)}
    }
    
    // 오토레이아웃 설정
    private func setUI(){
        grpTopView.snp.makeConstraints { make in
            make.height.equalTo(59)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        
        btnAlert.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(11)
            make.width.height.equalTo(24)
        }
        
        btnRecommandDrink.snp.makeConstraints { make in
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
    
//    public func config(nickname: String){
//        self.lblNickname.text = nickname
//    }
}

