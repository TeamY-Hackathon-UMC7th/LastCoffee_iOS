//
//  HomeAlertViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/27/25.
//

import UIKit


class HomeAlertViewController: UIViewController {
    weak var delegate: AlertViewControllerDelegate?
    private let nickname: String
    private lazy var alertView = HomeAlertView(nickname: nickname)
    
    init( nickname: String) {
        self.nickname = nickname
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = alertView
        
        setAction()
    }
    
    private func setAction() {
        alertView.noButton.addTarget(self, action: #selector(touchUpInsideNoButton), for: .touchUpInside)
        
        alertView.yesButton.addTarget(self, action: #selector(touchUpInsideYseButton), for: .touchUpInside)
    }
    
    // 아니오 버튼 액션
    @objc private func touchUpInsideNoButton() {
        delegate?.didDismissLogoutAlert()
        self.dismiss(animated: true)
    }
    
    // 네 버튼 액션
    @objc private func touchUpInsideYseButton() {
        
    }
}



