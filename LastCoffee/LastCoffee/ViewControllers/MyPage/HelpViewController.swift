//
//  HelpViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/27/25.
//

import UIKit

class HelpViewController: UIViewController {
    private let type: HelpViewType
    private let helpView: HelpView
    
    init(type: HelpViewType) {
        self.type = type
        self.helpView = HelpView(type: type)
        super.init(nibName: nil, bundle: nil)
        
        setNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view = helpView
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
        self.navigationItem.title = type.rawValue
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
