//
//  OnboardingViewController.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//

import UIKit
import KeychainSwift
import SwiftyToaster

class OnboardingViewController: UIViewController {
    private let onboardingView = KakaoLoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        viewSetting()
        setupActions()
    }
    
    func viewSetting() {
        view.addSubview(onboardingView)
        onboardingView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        onboardingView.kakaoBtn.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func kakaoLoginButtonTapped() {
        // 로그인 처리
        print("카카오 로그인하자!")
    }

}
