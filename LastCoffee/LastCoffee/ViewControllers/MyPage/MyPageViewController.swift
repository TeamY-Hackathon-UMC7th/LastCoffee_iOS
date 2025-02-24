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
    }
}
