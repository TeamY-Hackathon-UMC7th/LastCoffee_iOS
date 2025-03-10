//
//  DetailViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class SearchDetailViewController: UIViewController {
    public var receivedData: CoffeeDetailDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.view = detailView
        setNavigationBar()
        
        if let data = receivedData {
            detailView.updateNoteDetail(with: data)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.view = detailView
        setNavigationBar()
        
        if let data = receivedData {
            detailView.updateNoteDetail(with: data)
        }
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        let leftBarButton = UIBarButtonItem(image: .init(named: "Back"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private lazy var detailView: CompareDetailView = {
        let view = CompareDetailView()
        view.nextBtn.addTarget(self, action: #selector(goCompareView), for: .touchUpInside)
        return view
    }()
    
    // 버튼 클릭 시 비교 뷰로 이동하는 함수
    @objc private func goCompareView() {
        guard let selectItem = self.receivedData else { return }
        let compareCoffeeVC = CoffeeCompareSearchViewController()
        compareCoffeeVC.fristSelectedDrink = selectItem
        navigationController?.pushViewController(compareCoffeeVC, animated: true)
    }
}
