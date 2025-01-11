//
//  OnboardingViewController.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit

class OnboardingViewController: UIViewController {
    private let onboardingView = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewSetting()
        setupActions()
    }
    
    func viewSetting() {
        view.addSubview(onboardingView)
        onboardingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        onboardingView.checkButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

}
