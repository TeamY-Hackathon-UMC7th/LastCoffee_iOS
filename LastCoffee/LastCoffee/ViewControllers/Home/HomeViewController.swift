//
//  HomeViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit
import SwiftyToaster

class HomeViewController: UIViewController {
    private let myPageService = MyPageService()
    private let dummy = CoffeeDetailResponse.dummy()
    private let homeView = HomeView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var popularData = [CoffeeDetailResponse]()
    private var recommendData = [CoffeePreviewDTO]()
    private let networkService = CoffeeService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView

        self.addAction()
        self.setNavigation()
        self.getPopular()
        
        self.homeView.collectionView.delegate = self

        // 알림 권한 설정
        LocalNotificationHelper.shared.setAuthorization()
        LocalNotificationHelper.shared.printPendingNotification()
        
        // 첫 로그인 시에만 호출되도록 변경 필요함
        presentAlertView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNickname() // 닉네임 API 호출
     
        self.tabBarController?.tabBar.isHidden = false
        self.getLastRecommand()
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
                (cell as? FlowSectionCell)?.config(title: data.coffeeName, brand: data.brand, imageURL: data.coffeeImgUrl)
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
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 첫 로그인 시 얼럿 띄우기
    private func presentAlertView() {
        setBackgroundView(isHidden: false)
        let alertVC = HomeAlertViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.delegate = self  // Delegate 설정
        self.present(alertVC, animated: true)
    }
    
    // 얼럿 띄웠을 떄 백그라운드 투명도 처리
    public func setBackgroundView(isHidden: Bool) {
        homeView.backgroundView.isHidden = isHidden
    }
    
    private func getPopular(){
//        networkService.getPopularCoffee { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let response):
//                self.popularData = response.coffees
//                self.setDataSource()
//                self.setSnapShot()
//            case .failure(let error):
//                Toaster.shared.makeToast("\(error.errorDescription!)", .short)
//            }
//        }
    }
    
    func getLastRecommand(){
        Task {
            do {
                // 최근 추천받은 메뉴 불러오기
                let data = try await self.networkService.getRecentCoffees()
                if let coffeeData = data {
                    self.recommendData = coffeeData
                    self.setDataSource()
                    self.setSnapShot()
                    homeView.lblEmptyMenu.isHidden = !recommendData.isEmpty
                }
            } catch {
                Toaster.shared.makeToast("\(error)", .short)
            }
        }
    }
    
    // 닉네임 반환 API
    private func getNickname(){
        Task {
            do {
                let nickname = try await myPageService.getNickname()
                homeView.setNickname(nickname: nickname)
            }
            catch {
                print(error.localizedDescription)
                Toaster.shared.makeToast("닉네임을 가져오는데 실패했습니다.")
            }
        }
    }
}



extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = dataSource?.sectionIdentifier(for: indexPath.section)
        
        switch section {
        case .popularBanner:
            let nextVC = DetailViewController()
            nextVC.receivedData = popularData[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .flow:
            let nextVC = DetailViewController()
            let item = recommendData[indexPath.row]
            // 임시 처리
            let receivedData = CoffeeDetailResponse(id: item.id, name: item.coffeeName, brand: item.brand, sugar: 0, caffeine: 0, calories: 0, protein: 0, coffeeImgUrl: item.coffeeImgUrl)
            nextVC.receivedData = receivedData
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            return
        }
        
    }
}

// HomeAlertViewControllerDelegate 구현
extension HomeViewController: AlertViewControllerDelegate {
    func didDismissLogoutAlert() {
        setBackgroundView(isHidden: true)
    }
}
