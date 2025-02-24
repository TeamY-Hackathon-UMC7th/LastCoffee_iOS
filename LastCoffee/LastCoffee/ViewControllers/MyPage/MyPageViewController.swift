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
    
    private func setAction() {
        // 추천 내역 탭 제스처
        let recommendRecordViewTapGesutre = UITapGestureRecognizer(target: self, action: #selector(recommendRecordViewTapGesture))
        myPageView.recommendRecordView.addGestureRecognizer(recommendRecordViewTapGesutre)
        
        // 커피 기록 탭 제스처
        let coffeeRecordViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(coffeeRecordViewTapGesture))
        myPageView.coffeRecordView.addGestureRecognizer(coffeeRecordViewTapGesture)
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
}
