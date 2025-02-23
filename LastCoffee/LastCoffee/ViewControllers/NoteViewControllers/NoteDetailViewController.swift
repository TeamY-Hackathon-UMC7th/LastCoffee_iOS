//
//  NoteDetailViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit
import SwiftyToaster

class NoteDetailViewController: UIViewController {
    public var receivedData: NoteModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = noteDetailView
        self.tabBarController?.tabBar.isHidden = true
        
        if let data = receivedData {
            noteDetailView.imageView.sd_setImage(with: URL(string: data.coffeeImgUrl))
            noteDetailView.coffeeName.text = "[\(data.brand)] \(data.coffeeName)"
            noteDetailView.drinking.text = "마신 일시  |  \(extractDateTime(from: data.drinkDate))"
            noteDetailView.sleeping.text = "취침 시간  |  \(extractDateTime(from: data.sleepDate))"
            noteDetailView.reviewContents.text = data.comment
            noteDetailView.createdAt.text = extractDateTime(from: data.createdAt)
        }
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.view = noteDetailView
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if let data = receivedData {
            noteDetailView.imageView.sd_setImage(with: URL(string: data.coffeeImgUrl))
            noteDetailView.coffeeName.text = "[\(data.brand)] \(data.coffeeName)"
            noteDetailView.drinking.text = "마신 일시  |  \(extractDateTime(from: data.drinkDate))"
            noteDetailView.sleeping.text = "취침 시간  |  \(extractDateTime(from: data.sleepDate))"
            noteDetailView.reviewContents.text = data.comment
            noteDetailView.createdAt.text = extractDateTime(from: data.createdAt)
        }
        
        setNavigationBar()
        self.view.layoutIfNeeded()
    }
    
    private lazy var noteDetailView: NoteDetailView = {
        let view = NoteDetailView()
        return view
    }()
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(named: "Back"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func extractDateTime(from dateTimeString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = inputFormatter.date(from: dateTimeString) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "ko_KR")
            outputFormatter.dateFormat = "yyyy년 MM월 dd일 a h시"
            return outputFormatter.string(from: date)
        } else {
            return "날짜 형식 없음"
        }
    }
}

