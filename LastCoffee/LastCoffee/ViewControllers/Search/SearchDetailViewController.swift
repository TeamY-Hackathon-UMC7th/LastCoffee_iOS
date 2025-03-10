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
        view.nextBtn.addTarget(self, action: #selector(goAddView), for: .touchUpInside)
        return view
    }()
    
    @objc private func goAddView() {
        guard let selectItem = self.receivedData else { return }
        let addCoffeeVC = CoffeeCompareSearchViewController()
        addCoffeeVC.fristSelectedDrink = selectItem
        navigationController?.pushViewController(addCoffeeVC, animated: true)
    }
}
