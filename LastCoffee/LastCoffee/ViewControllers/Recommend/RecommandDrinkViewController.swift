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
    private let networkService = CoffeeService()
    private var recommendData = [CoffeeDetailResponse]()
    let coffeeManager = CoffeeManager()
   
    init(selectedHour: String) {
        self.selectedHour = selectedHour
        self.recommendView = RecommendDrinkView(selectedHour: selectedHour)
        super.init(nibName: nil, bundle: nil)
        
        self.view = recommendView
        setAction()
        setNavigationBar()
        getRecommend()
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
        if let targetIndex = navigationController.viewControllers.firstIndex(where: { $0 is HomeViewController }) {
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
            (cell as? RecommendBannerCell)?.config(title: self.recommendData[indexPath.row].name, brand: self.recommendData[indexPath.row].brand, imageURL: self.recommendData[indexPath.row].coffeeImgUrl)
            return cell
        })
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        let recommendSection = Section.recommmandBanner
        
        snapshot.appendSections([recommendSection])
        snapshot.appendItems(recommendData.map{Item.recommendMenu($0)}, toSection: recommendSection)
        
        dataSource?.apply(snapshot)
    }
    
    private func getRecommend(){
        networkService.getRecommandCoffee(time: self.selectedHour){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.recommendData = response.coffees
                self.setDataSource()
                self.setSnapShot()
                
                Task {
                    self.makeData(selectedHour: self.selectedHour, coffee: response.coffees)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func makeData(selectedHour : String, coffee : [CoffeeDetailResponse]) {
        var coffees = [CoffeeData]()
        for data in coffee {
            coffees.append(CoffeeData(searchTime: selectedHour,
                                      id: data.id,
                                      name: data.name,
                                      brand: data.brand,
                                      sugar: data.sugar,
                                      caffeine: data.caffeine,
                                      calories: data.calories,
                                      protein: data.protein,
                                      coffeeImgUrl: data.coffeeImgUrl))
        }
        Task {
            try await self.coffeeManager.deleteAllCoffeeData()
            try await self.coffeeManager.saveCoffeeData(coffees: coffees)
        }
    }
}

