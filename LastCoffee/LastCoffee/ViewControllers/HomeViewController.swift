//
//  HomeViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view = homeView
        self.addAction()
        self.setDataSource()
        
        // API 연결 후 스냅샷 생성 추가 예정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setDataSource() {
//        dataSource = UICollectionViewDiffableDataSource(collectionView: homeView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            switch itemIdentifier {
//            case .popularMenu: // 각 셀에 config 설정
//            case .recommandMenu:
//            default:
//                return UICollectionViewCell()
//            }
//        })
    }

    private func addAction() {
        // '오늘의 취침 시간' 버튼 선택
        homeView.btnRecommandDrink.addTarget(self, action: #selector(touchUpInsideBtnRecommandDrink), for: .touchUpInside)
    }
    
    // '오늘의 취침 시간' 버튼 선택
    @objc private func touchUpInsideBtnRecommandDrink() {
//        let nextVC = SelectTimeViewController()
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


