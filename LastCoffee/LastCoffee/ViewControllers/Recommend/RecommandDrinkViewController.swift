//
//  RecommendDrinkViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import UIKit

class RecommendDrinkViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private let selectedHour : String
    private let recommendView : RecommendDrinkView
   
    init(selectedHour: String) {
        self.selectedHour = selectedHour
        self.recommendView = RecommendDrinkView(selectedHour: selectedHour)
        super.init(nibName: nil, bundle: nil)
        
        self.view = recommendView
        setDataSource()
        setNavigationBar()
        // API 연결
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
//        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: recommendView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendBannerCell.id, for: indexPath)
//            (cell as? RecommendBannerCell)?.config(title: <#T##String#>, imageURL: <#T##String#>)
//            return cell
//        })
    }
}

