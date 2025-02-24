//
//  RecommendRecordViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit

class RecommendRecordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.title = "추천 내역"
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
