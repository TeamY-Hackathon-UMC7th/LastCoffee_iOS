//
//  AlertSettingViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit
import SwiftyToaster

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
        
        // 알림 시간, 알람 설정
        let time = LoginViewController.keychain.get(KeychainKey.alertTime.rawValue) ?? "16"
        let isAlertOn = LoginViewController.keychain.getBool(KeychainKey.isOnAlert.rawValue) ?? false
        alertSettingView.config(alertTime: time, isOn: isAlertOn)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setAction() {
        let changeAlertTimeGroupTapGesture = UITapGestureRecognizer(target: self, action: #selector(changeAlertTimeGroupTapGesutre))
        alertSettingView.changeAlertTimeGroupView.addGestureRecognizer(changeAlertTimeGroupTapGesture)
        
        alertSettingView.alertSwitch.addTarget(self, action: #selector(valueChangeAlertSwitch(_:)), for: .valueChanged)
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
    
    
    // 알림 스위치 액션
    @objc private func valueChangeAlertSwitch(_ switchView: UISwitch){
        LoginViewController.keychain.set(switchView.isOn, forKey: KeychainKey.isOnAlert.rawValue)
        
        
        // 스위치 on이면 알림 설정
        if switchView.isOn {
            // 모든 알림 삭제
            LocalNotificationHelper.shared.removeAllNotification()
            
            // 매일 16시마다 알림 설정
            LocalNotificationHelper.shared.pushScheduledNotification(title: PushAlert.contentTitle, body: PushAlert.contentBody, hour: 20, identifier: PushAlert.alertId)
            Toaster.shared.makeToast("오후 4시, 푸시 알림이 설정되었습니다!", .short)
        } else {
            LocalNotificationHelper.shared.removeAllNotification()
            
            Toaster.shared.makeToast("푸시 알림 설정이 거부되었습니다.", .short)
        }
        
        // 알림 모두 보기
        LocalNotificationHelper.shared.printPendingNotification()
    }
}
