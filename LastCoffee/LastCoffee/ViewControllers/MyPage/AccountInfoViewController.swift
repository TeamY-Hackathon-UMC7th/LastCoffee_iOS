//
//  AccountInfoViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit

class AccountInfoViewController: UIViewController {
    private let accountInfoView = AccountInfoView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = accountInfoView
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.title = "계정 정보"
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
