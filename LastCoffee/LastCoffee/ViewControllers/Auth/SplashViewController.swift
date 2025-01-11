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
            make.top.equalTo(ScreenHeight * 0.4)
        }
    }
    
    func navigateToOnBoaringScreen() {
        let onboardingVC = OnboardingViewController()
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
}
