//
//  WithdrawAlertViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class WithdrawAlertViewController: UIViewController {
    weak var delegate: AlertViewControllerDelegate?
    private let withdrawAlertView = WithdrawAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = withdrawAlertView
        
        setAction()
    }
    
    private func setAction() {
        withdrawAlertView.cancelButton.addTarget(self, action: #selector(touchUpInsideCancelButton), for: .touchUpInside)
        
        withdrawAlertView.withdrawButton.addTarget(self, action: #selector(touchUpInsideWithdrawButton), for: .touchUpInside)
    }
    
    // 취소 버튼 액션
    @objc private func touchUpInsideCancelButton() {
        delegate?.didDismissLogoutAlert()
        self.dismiss(animated: true)
    }
    
    // 탈퇴 버튼 액션
    @objc private func touchUpInsideWithdrawButton() {
        
    }
}


