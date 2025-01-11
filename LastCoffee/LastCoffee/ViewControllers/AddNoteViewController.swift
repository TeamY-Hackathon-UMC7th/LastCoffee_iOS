//
//  AddNoteViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class AddNoteViewController: UIViewController {
    let networkService = ReviewService()
    
    public var receivedData: CoffeeDetailResponse!
    
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
        view.saveBtn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
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
    
    @objc func clickBtn() {
        callPostAPI()
        navigationController?.popViewController(animated: true)
        guard let navigationController = navigationController else { return }
        if let targetIndex = navigationController.viewControllers.firstIndex(where: { $0 is NoteMainViewController }) {
             let newStack = Array(navigationController.viewControllers[...targetIndex])
             navigationController.setViewControllers(newStack, animated: true)
         }
    }
     
    
    func callPostAPI() {
        guard let drinkingDate = self.drinkingDate,
              let sleepingDate = self.sleepingDate else { return }
        let review = networkService.makeReviewDto(coffeeKey: receivedData.id, comment: addNoteView.reviewTextView.text, drinkTime: drinkingDate, sleepTime: sleepingDate)
        
        networkService.postReview(reviewDto: review, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error)
            }
        })
    }
}

