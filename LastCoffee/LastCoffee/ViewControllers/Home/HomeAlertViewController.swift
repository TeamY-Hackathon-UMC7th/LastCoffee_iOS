//
//  HomeAlertViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/27/25.
//

import UIKit
import SwiftyToaster



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
        // 아니요 버튼 액션
        alertView.noButton.addTarget(self, action: #selector(touchUpInsideNoButton), for: .touchUpInside)
        
        // 네 버튼 액션
        alertView.yesButton.addTarget(self, action: #selector(touchUpInsideYseButton), for: .touchUpInside)
        
        // 시간 변경 버튼 액션
        alertView.changeTimeButton.addTarget(self, action: #selector(touchUpInsideChangeTimeButton), for: .touchUpInside)
    }
    
    // 아니오 버튼 액션
    @objc private func touchUpInsideNoButton() {
        delegate?.didDismissLogoutAlert()
        // 모든 알림 삭제
        LocalNotificationHelper.shared.removeAllNotification()
        
        Toaster.shared.makeToast("푸시 알림 설정이 거부되었습니다.", .short)
        self.dismiss(animated: true)
    }
    
    // 네 버튼 액션
    @objc private func touchUpInsideYseButton() {

        // 키체인에 얼럿 시간, 유무 설정
        SplashViewController.keychain.set("16", forKey: KeychainKey.alertTime.rawValue)
        SplashViewController.keychain.set(true, forKey: KeychainKey.isOnAlert.rawValue)
        
        // 얼럿 설정
        delegate?.didDismissLogoutAlert()
        
        // 모든 알림 삭제
        LocalNotificationHelper.shared.removeAllNotification()
        
        // 매일 16시마다 알림 설정
        LocalNotificationHelper.shared.pushScheduledNotification(title: PushAlert.contentTitle, body: PushAlert.contentBody, hour: 16, identifier: PushAlert.alertId)
        Toaster.shared.makeToast("오후 4시, 푸시 알림이 설정되었습니다!", .short)
        self.dismiss(animated: true)

    }
    
    // 시간 변경 버튼 액션
    @objc private func touchUpInsideChangeTimeButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.delegate?.didDismissLogoutAlert()
            self.dismiss(animated: true) {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let window = windowScene.windows.first,
                      let tabBarController = window.rootViewController as? UITabBarController else {
                    print("탭바 없음")
                    return
                }

                // 1. 마이페이지 탭으로 변경
                tabBarController.selectedIndex = 3
                
                // 2. 마이페이지의 네비게이션 컨트롤러 가져오기
                if let myPageNav = tabBarController.viewControllers?[3] as? UINavigationController {
                    // 3. AlertSettingVC 푸시
                    let alertSettingVC = AlertSettingViewController()
                    myPageNav.pushViewController(alertSettingVC, animated: false)

                    // 4. AlertSelectTimeVC 푸시
                    let alertSelectTimeVC = AlertSelectTimeViewController()
                    myPageNav.pushViewController(alertSelectTimeVC, animated: true)

                }
            }
        }
    }
}



