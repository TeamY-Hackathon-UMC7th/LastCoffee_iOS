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
        // 로그아웃 버튼 액션
        accountInfoView.logoutButton.addTarget(self, action: #selector(touchUpInsideLogoutButton), for: .touchUpInside)
        
        // 회원탈퇴 버튼 액션
        accountInfoView.withdrawButton.addTarget(self, action: #selector(touchUpInsideWitdhdarwButton), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.title = "계정 정보"
    }
    
    // 내비게이션 바 뒤로 가기 버튼
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 로그아웃 버튼
    @objc private func touchUpInsideLogoutButton() {
        setBackgroundView(isHidden: false)
        let alertVC = LogoutAlertViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.delegate = self  // Delegate 설정
        self.present(alertVC, animated: true)
    }
    
    // 탈퇴 버튼
    @objc private func touchUpInsideWitdhdarwButton() {
        setBackgroundView(isHidden: false)
        let alertVC = WithdrawAlertViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.delegate = self  // Delegate 설정
        self.present(alertVC, animated: true)
    }
    
    // 얼럿 띄웠을 떄 백그라운드 투명도 처리
    public func setBackgroundView(isHidden: Bool) {
        accountInfoView.backgroundView.isHidden = isHidden
    }
}

// LogoutAlertViewControllerDelegate 구현
extension AccountInfoViewController: AlertViewControllerDelegate {
    func didDismissLogoutAlert() {
        setBackgroundView(isHidden: true)
    }
}
