//
//  DetailViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class DetailViewController: UIViewController {
    public var receivedData: NoteSearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        self.navigationController?.isNavigationBarHidden = false
        
        if let data = receivedData {
            detailView.coffeeName.text = data.name
        }
    }
    
    private lazy var detailView: DetailView = {
        let view = DetailView()
        return view
    }()
}

