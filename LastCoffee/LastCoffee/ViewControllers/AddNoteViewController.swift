//
//  AddNoteViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class AddNoteViewController: UIViewController {
    public var receivedData: NoteSearchModel!
    
    public var drinkingDate: Date!
    public var sleepingDate: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addNoteView
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "새 기록"
        
        if let data = receivedData {
            addNoteView.selectedCoffee.text = data.name
            self.view.layoutIfNeeded()
        }
    }
    
    private lazy var addNoteView: AddNoteView = {
        let view = AddNoteView()
        view.drinkingPicker.addTarget(self, action: #selector(drinkingDateValueChanged(_:)), for: .valueChanged)
        view.sleepingPicker.addTarget(self, action: #selector(sleepingDateValueChanged(_:)), for: .valueChanged)
        return view
    }()
    
    @objc func drinkingDateValueChanged(_ sender: UIDatePicker) {
        let date = sender.date
        drinkingDate = date
    }
    
    @objc func sleepingDateValueChanged(_ sender: UIDatePicker) {
        let date = sender.date
        sleepingDate = date
    }
}

