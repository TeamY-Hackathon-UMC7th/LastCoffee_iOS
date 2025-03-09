//
//  SplashViewController.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import UIKit
import SnapKit

public class SplashViewController : UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "SplashLogo")
        logoImage.contentMode = .scaleAspectFit
        return logoImage
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "SplashBack")
        logoImage.contentMode = .scaleAspectFit
        return logoImage
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkToken()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.mainColor
        view.addSubview(backgroundImage)
        view.addSubview(logoImage)
    }
    
    func setConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        logoImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalTo(DynamicPadding.superViewHeight * 0.4)
            make.width.equalTo(DynamicPadding.dynamicValuebyWidth(96.0))
        }
    }
    
    // 토큰 검사
    func checkToken() {
        if TokenManager.shared.isRefreshTokenValid() {
            DispatchQueue.main.async {
                self.navigateToMainScreen()
            }
        } else {
            DispatchQueue.main.async {
                self.navigateToOnBoaringScreen()
            }
        }
    }
    
    private func navigateToOnBoaringScreen() {
        let onboardingVC = OnboardingViewController()
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
    private func navigateToMainScreen() {
        let tabVC = MainTabBarController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let rootVC = UINavigationController(rootViewController: tabVC)
            
            window.rootViewController = rootVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
