//
//  AddNoteViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class AddNoteViewController: UIViewController {
    public var receivedData: NoteSearchModel?

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
        return view
    }()

}

