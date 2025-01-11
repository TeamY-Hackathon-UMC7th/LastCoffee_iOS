//
//  HomeViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

class HomeViewController: UIViewController {
    private let dummy = CoffeeDetailResponse.dummy()
    private let homeView : HomeView
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var popularData = [CoffeeDetailResponse]()
    private var recommendData = [CoffeeDetailResponse]()
    
    private let networkService = CoffeeService()
    
    
    init() {
        let nickname = LoginViewController.keychain.get("userNickname")
        homeView = HomeView(nickname: nickname ?? "default")
        
        super.init(nibName: nil, bundle: nil)
        self.view = homeView
        self.addAction()
        self.setNavigation()
        self.getPopular()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.isTabBarHidden = false
        
        self.setDataSource()
        self.setSnapShot()
    
        homeView.lblEmptyMenu.isHidden = !recommendData.isEmpty
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: homeView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .popularMenu: // 각 셀에 config 설정
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularBannerSectionCell.id, for: indexPath)
                let data = self.popularData[indexPath.row]
                (cell as? PopularBannerSectionCell)?.config(title: data.name, brand: data.brand, imageURL: data.coffeeImgUrl, cafeine: data.caffeine, sugar: data.sugar, calorie: data.calories, protein: data.protein)
                return cell
            case .flowMenu:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowSectionCell.id, for: indexPath)
                let data = self.recommendData[indexPath.row]
                (cell as? FlowSectionCell)?.config(title: data.name, brand: data.brand, imageURL: data.coffeeImgUrl)
                return cell
            case .recommendMenu(_):
                return UICollectionViewCell()
            }
        })
        
        dataSource?.supplementaryViewProvider = {[weak self] (collectionView, kind, indexPath) in
            
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            switch section {
            case .popularBanner(let header):
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath)
                (headerView as? HeaderView)?.config(title: header)
                return headerView
            case .flow(let header):
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath)
                (headerView as? HeaderView)?.config(title: header)
                return headerView
            default:
                return nil
            }
        }
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        let popularSection = Section.popularBanner("☕️ 인기 메뉴")
        let flowSection = Section.flow("🧑🏻 최근에 추천 받은 메뉴")
        
        snapshot.appendSections([popularSection, flowSection])
        snapshot.appendItems(popularData.map{Item.popularMenu($0)}, toSection: popularSection)
        snapshot.appendItems(recommendData.map{Item.flowMenu($0)}, toSection: flowSection)
        
        
        dataSource?.apply(snapshot)
    }
    
    private func setNavigation() {
        // 로고 이미지 뷰
         let logoImageView = UIImageView().then { view in
            view.image = .lastCoffeeText
        }
        
        self.navigationItem.titleView = logoImageView
    }

    private func addAction() {
        // '오늘의 취침 시간' 버튼 선택
        homeView.btnRecommendDrink.addTarget(self, action: #selector(touchUpInsideBtnRecommendDrink), for: .touchUpInside)
    }
    
    // '오늘의 취침 시간' 버튼 선택
    @objc private func touchUpInsideBtnRecommendDrink() {
        let nextVC = SelectTimeViewController()
        self.tabBarController?.isTabBarHidden = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func getPopular(){
        networkService.getPopularCoffee { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.popularData = response.coffees
                self.setDataSource()
                self.setSnapShot()
            case .failure(let error):
                print(error)
            }
        }
    }
}


