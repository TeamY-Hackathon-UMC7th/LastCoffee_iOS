//
//  ChangePasswordViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    private let changePasswordView = ChangePasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = changePasswordView
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.title = "비밀번호 변경"
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
