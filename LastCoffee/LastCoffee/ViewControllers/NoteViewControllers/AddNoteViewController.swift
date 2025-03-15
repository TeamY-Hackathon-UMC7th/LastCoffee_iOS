//
//  AddNoteViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class AddNoteViewController: UIViewController {
    let networkService = NoteService()
    
    public var receivedData: CoffeeDetailDTO?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.view = addNoteView
        self.navigationController?.isNavigationBarHidden = false
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
    
    private func callPostAPI() {
        Task {
            do {
                guard let coffeeId = receivedData?.id else { return }
                let newNoteDTO = networkService.makeNoteDTO(
                    drinkDateTime: drinkingDate,
                    sleepDateTime: sleepingDate,
                    review: addNoteView.reviewTextView.text,
                    coffeeId: coffeeId
                )
                startLoading()
                _ = try await networkService.postNote(data: newNoteDTO)
                
                stopLoading()
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: NSNotification.Name("NewNoteAdded"),
                        object: nil
                    )
                    
                    self.navigationController?.popViewController(animated: true)
                    guard let navigationController = self.navigationController else { return }
                    if let targetIndex = navigationController.viewControllers.firstIndex(where: { $0 is NoteMainViewController }) {
                        let newStack = Array(navigationController.viewControllers[...targetIndex])
                        navigationController.setViewControllers(newStack, animated: true)
                    }
                }
            } catch {
                stopLoading()
                print(error.localizedDescription)
            }
        }
    }
}

