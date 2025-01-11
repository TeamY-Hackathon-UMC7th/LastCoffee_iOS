//
//  NoteDetailViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteDetailViewController: UIViewController {
    public var receivedData: NoteModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = noteDetailView
        
        if let data = receivedData {
            noteDetailView.coffeeName.text = data.coffeeName
            noteDetailView.drinking.text = "마신 일시 | " + data.drinkingDate + " " + data.drinkingTime
            noteDetailView.sleeping.text = "취침 시간 | " + data.sleepingDate + " " + data.sleepingTime
            noteDetailView.reviewContents.text = data.review
        }
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.view = noteDetailView
        self.navigationController?.isNavigationBarHidden = false
        
        if let data = receivedData {
            noteDetailView.coffeeName.text = data.coffeeName
            noteDetailView.drinking.text = "마신 일시 | " + data.drinkingDate + " " + data.drinkingTime
            noteDetailView.sleeping.text = "취침 시간 | " + data.sleepingDate + " " + data.sleepingTime
            noteDetailView.reviewContents.text = data.review
        }
        
        setNavigationBar()
        self.view.layoutIfNeeded()
    }
    
    private lazy var noteDetailView: NoteDetailView = {
        let view = NoteDetailView()
        return view
    }()
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

