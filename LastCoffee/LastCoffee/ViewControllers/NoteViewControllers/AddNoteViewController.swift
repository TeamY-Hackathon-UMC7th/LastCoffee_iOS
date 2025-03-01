//
//  AddNoteViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit
import SwiftyToaster

class AddNoteViewController: UIViewController {
    let networkService = ReviewService()
    
    public var receivedData: CoffeeDetailResponse!
    
    public var drinkingDate: Date = Date()
    public var sleepingDate: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addNoteView
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "새 기록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.ptdMediumFont(ofSize: 18)]
        
        if let data = receivedData {
            addNoteView.selectedCoffee.text = "[\(data.brand)] \(data.name)"
            self.view.layoutIfNeeded()
        }
        setNavigationBar()
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
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(named: "Back"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callPostAPI() {
        let review = networkService.makeReviewDto(coffeeKey: receivedData.id, comment: addNoteView.reviewTextView.text, drinkTime: drinkingDate, sleepTime: sleepingDate)
        
        networkService.postReview(reviewDto: review, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                Toaster.shared.makeToast("기록이 삭제되었습니다.", .short)
                Task {
                    self.navigationController?.popViewController(animated: true)
                    guard let navigationController = self.navigationController else { return }
                    if let targetIndex = navigationController.viewControllers.firstIndex(where: { $0 is NoteMainViewController }) {
                         let newStack = Array(navigationController.viewControllers[...targetIndex])
                         navigationController.setViewControllers(newStack, animated: true)
                     }
                }
            case .failure(let error):
                Toaster.shared.makeToast("\(error.errorDescription!)", .short)
            }
        })
    }
}

