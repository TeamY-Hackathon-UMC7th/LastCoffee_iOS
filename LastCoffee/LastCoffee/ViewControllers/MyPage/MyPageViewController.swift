//
//  MyPageViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit


class MyPageViewController: UIViewController {
    private let myPageView = MyPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = myPageView
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setAction() {
        // 추천 내역 탭 제스처
        let recommendRecordViewTapGesutre = UITapGestureRecognizer(target: self, action: #selector(recommendRecordViewTapGesture))
        myPageView.recommendRecordView.addGestureRecognizer(recommendRecordViewTapGesutre)
        
        // 커피 기록 탭 제스처
        let coffeeRecordViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(coffeeRecordViewTapGesture))
        myPageView.coffeRecordView.addGestureRecognizer(coffeeRecordViewTapGesture)
        
        
        // 계정 정보 버튼 액션
        myPageView.accountInfoView.button.addTarget(self, action: #selector(touchUpInsideAccountInfo), for: .touchUpInside)
        
        // 알림 설정 버튼 액션
        myPageView.alertSettingView.button.addTarget(self, action: #selector(touchUpInsideAlertSettingButton), for: .touchUpInside)
        
        // 닉네임 변경 버튼 액션
        myPageView.changeNicknameView.button.addTarget(self, action: #selector(touchUpInsideChangeNicknameButton), for: .touchUpInside)
    }
    
    // 커피 기록 탭 제스처
    @objc private func coffeeRecordViewTapGesture() {
        self.tabBarController?.selectedIndex = 1
    }
    
    // 추천 내역 탭 제스처
    @objc private func recommendRecordViewTapGesture() {
        let nextVC = RecommendRecordViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 계정 정보 버튼 액션
    @objc private func touchUpInsideAccountInfo() {
        let nextVC = AccountInfoViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 알림 설정 버튼 액션
    @objc private func touchUpInsideAlertSettingButton() {
        let nextVC = AlertSettingViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 닉네임 변경 탭
    @objc private func touchUpInsideChangeNicknameButton(){
        let nextVC = ChangeNicknameViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
