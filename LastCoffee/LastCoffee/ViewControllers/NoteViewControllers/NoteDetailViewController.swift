//
//  NoteDetailViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteDetailViewController: UIViewController {
    let networkService = NoteService()
    
    public var receivedId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = noteDetailView
        self.tabBarController?.tabBar.isHidden = true
        
        if let data = receivedId {
            callGetDetailAPI(noteId: data)
        }
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.view = noteDetailView
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if let data = receivedId {
            callGetDetailAPI(noteId: data)
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
    
    func callGetDetailAPI(noteId: Int) {
        Task {
            do {
                let data = try await networkService.getNote(noteId: noteId)
                
                let detail = NoteDetailModel(
                    id: data.coffee.id,
                    brand: data.coffee.brand,
                    coffeeName: data.coffee.coffeeName,
                    coffeeImgUrl: data.coffee.coffeeImgUrl,
                    writeDate: data.writeDate,
                    drinkDate: data.drinkDate,
                    sleepDate: data.sleepDate,
                    review: data.review
                )
                
                DispatchQueue.main.async {
                    self.noteDetailView.updateNoteDetail(with: detail)
                }
            }
            catch {
                print(error)
            }
        }
    }
}

