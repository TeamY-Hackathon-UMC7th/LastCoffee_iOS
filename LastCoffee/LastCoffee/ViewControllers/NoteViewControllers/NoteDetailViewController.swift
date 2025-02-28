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
            noteDetailView.updateNoteDetail(with: data)
        }
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.view = noteDetailView
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if let data = receivedData {
            noteDetailView.updateNoteDetail(with: data)
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
}

