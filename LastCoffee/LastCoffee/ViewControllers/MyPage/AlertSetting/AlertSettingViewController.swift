//
//  AlertSettingViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class AlertSettingViewController: UIViewController {
    private let alertSettingView = AlertSettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = alertSettingView
        
        setNavigationBar()
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setAction() {
        let changeAlertTimeGroupTapGesture = UITapGestureRecognizer(target: self, action: #selector(changeAlertTimeGroupTapGesutre))
        alertSettingView.changeAlertTimeGroupView.addGestureRecognizer(changeAlertTimeGroupTapGesture)
    }
    
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.title = "알림 설정"
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func changeAlertTimeGroupTapGesutre(){
        print("changeAlertTimeGroupTapGesutre")
        let nextVC = AlertSelectTimeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
