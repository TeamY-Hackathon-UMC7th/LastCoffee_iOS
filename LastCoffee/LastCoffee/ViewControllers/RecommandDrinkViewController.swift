//
//  RecommandDrinkViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import UIKit

class RecommandDrinkViewController: UIViewController {
    private let selectedHour : String
    private let recommandView : RecommandDrinkView
   
    init(selectedHour: String) {
        self.selectedHour = selectedHour
        self.recommandView = RecommandDrinkView(selectedHour: selectedHour)
        super.init(nibName: nil, bundle: nil)
        
        self.view = recommandView
        
        // API 연결
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

