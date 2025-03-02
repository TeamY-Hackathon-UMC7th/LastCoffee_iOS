//
//  MyPageViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit
import SwiftyToaster

class MyPageViewController: UIViewController {
    private let myPageView = MyPageView()
    private let myPageService = MyPageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = myPageView
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        getNickname() // 닉네임 반환 API 호출
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
        
        // 서비스 이용역관 버튼 액션
        myPageView.serviceInfoView.button.addTarget(self, action: #selector(touchUpInsideServiceInfoButton), for: .touchUpInside)
        
        // 개인정보처리방침 버튼 액션
        myPageView.personalInfoView.button.addTarget(self, action: #selector(touchUpInsidePersonalInfoButton), for: .touchUpInside)
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
    
    // 닉네임 변경 버튼 액션
    @objc private func touchUpInsideChangeNicknameButton(){
        let nextVC = ChangeNicknameViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 서비스 이용역관 버튼 액션
    @objc private func touchUpInsideServiceInfoButton(){
        let nextVC = HelpViewController(type: .termsOfUse)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 개인정보처리방침 버튼 액션
    @objc private func touchUpInsidePersonalInfoButton(){
        let nextVC = HelpViewController(type: .personalInfomantionProcessingPolicy)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 닉네임 반환 API
    private func getNickname(){
        Task {
            do {
                let nickname = try await myPageService.getNickname()
                myPageView.config(nickname: nickname)
            }
            catch {
                print(error.localizedDescription)
                Toaster.shared.makeToast("닉네임을 가져오는데 실패했습니다.")
            }
        }
    }
}
