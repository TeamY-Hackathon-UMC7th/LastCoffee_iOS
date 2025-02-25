//
//  LogoutAlertViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

protocol AlertViewControllerDelegate: AnyObject {
    func didDismissLogoutAlert()
}

class LogoutAlertViewController: UIViewController {
    weak var delegate: AlertViewControllerDelegate?
    private let logoutAlertView = LogoutAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = logoutAlertView
        
        setAction()
    }
    
    private func setAction() {
        logoutAlertView.cancelButton.addTarget(self, action: #selector(touchUpInsideCancelButton), for: .touchUpInside)
        
        logoutAlertView.confirmButton.addTarget(self, action: #selector(touchUpInsideConfirmButton), for: .touchUpInside)
    }
    
    // 취소 버튼 액션
    @objc private func touchUpInsideCancelButton() {
        delegate?.didDismissLogoutAlert()
        self.dismiss(animated: true)
    }
    
    // 확인 버튼 액션
    @objc private func touchUpInsideConfirmButton() {
        
    }
}


