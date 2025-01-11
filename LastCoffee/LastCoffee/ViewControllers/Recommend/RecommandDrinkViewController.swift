//
//  RecommendDrinkViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import UIKit

class RecommendDrinkViewController: UIViewController {
    private let dummy = CoffeeDetailResponse.dummy()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private let selectedHour : String
    private let recommendView : RecommendDrinkView
   
    init(selectedHour: String) {
        self.selectedHour = selectedHour
        self.recommendView = RecommendDrinkView(selectedHour: selectedHour)
        super.init(nibName: nil, bundle: nil)
        
        self.view = recommendView
        setDataSource()
        setSnapShot()
        setAction()
        setNavigationBar()
        
        // API 연결
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setAction() {
        recommendView.btnCheck.addTarget(self, action: #selector(touchUpInsideBtnCheck), for: .touchUpInside)
    }
    
    @objc private func touchUpInsideBtnCheck() {
        guard let navigationController = navigationController else { return }
         // VisiterHomeViewController를 스택에서 찾기
        if let targetIndex = navigationController.viewControllers.firstIndex(where: { $0 is HomeViewController }) {
             // VisiterHomeViewController까지의 스택만 유지
             let newStack = Array(navigationController.viewControllers[...targetIndex])
             navigationController.setViewControllers(newStack, animated: true)
         }
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func setDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: recommendView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendBannerCell.id, for: indexPath)
            (cell as? RecommendBannerCell)?.config(title: self.dummy[indexPath.row].name, brand: self.dummy[indexPath.row].brand, imageURL: self.dummy[indexPath.row].coffeeImgUrl)
            return cell
        })
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        let recommendSection = Section.recommmandBanner
        
        snapshot.appendSections([recommendSection])
        
        snapshot.appendItems(dummy.map{Item.recommendMenu($0)}, toSection: recommendSection)
        
        dataSource?.apply(snapshot)
    }
}

