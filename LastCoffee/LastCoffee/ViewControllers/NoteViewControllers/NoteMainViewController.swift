//
//  NoteMainViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit
import SwiftyToaster

class NoteMainViewController: UIViewController {
    let networkService = ReviewService()
    private var data: [NoteModel] = [
        NoteModel(id: 13,coffeeName: "아메리카노", brand: "스타벅스", drinkDate: "2024-11-12 16:34", sleepDate: "2024-11-12 23:25", comment: "아메리카노도 잠이 안온다...", coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B110563%5D_20210426095937947.jpg", createdAt: "2024-11-13 00:30"),
        NoteModel(id: 59,coffeeName: "블루베리라떼", brand: "컴포즈", drinkDate: "2025-01-09 19:34", sleepDate: "2025-01-09 22:06", comment: "블루베리라떼 맛있음", coffeeImgUrl: "https://composecoffee.com/files/thumbnails/891/064/1515x2083.crop.jpg?t=1733793666", createdAt: "2025-01-09 23:00"),
        NoteModel(id: 85,coffeeName: "유자티", brand: "컴포즈", drinkDate: "2025-01-09 20:34", sleepDate: "2025-01-09 23:56", comment: "유자티는 따뜻하다..", coffeeImgUrl: "https://composecoffee.com/files/thumbnails/682/038/1515x2083.crop.jpg?t=1733794981", createdAt: "2025-02-13 00:20")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.view = noteView
        callGetAPI()
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.view = noteView
        callGetAPI()
        setupDelegate()
        Task {
            self.noteView.noteTableView.reloadData()
        }
    }
    
    private lazy var noteView: NoteMainView = {
        let view = NoteMainView()
        view.addBtn.addTarget(self, action: #selector(goSearchView), for: .touchUpInside)
        return view
    }()
    
    private func setupDelegate() {
        noteView.noteTableView.delegate = self
        noteView.noteTableView.dataSource = self
    }
    
    @objc private func goSearchView() {
        let noteSearchVC = NoteSearchViewController()
        navigationController?.pushViewController(noteSearchVC, animated: true)
    }

    // 셀 클릭 시 실행할 함수
    private func handleCellTap(_ item: NoteModel) {
        let noteDetailVC = NoteDetailViewController()
        noteDetailVC.receivedData = item
        noteDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    func callGetAPI() {
        networkService.getReviews { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let reviews):
                self.data.removeAll()
                guard let review = reviews else { return }
                for data in review {
//                    guard let drinkTimeString = convertISO8601ToCustomFormat(data.drinkTime) else {
//                        return
//                    }
                    let drinkStrings = data.drinkTime.split(separator: "T").map{String($0)}
//                    let drinkStrings = drinkTimeString.split(separator: " ").map{String($0)}
//                    guard let sleepTimeString = convertISO8601ToCustomFormat(data.sleepTime) else {return}

                    let sleepStrings = data.sleepTime.split(separator: "T").map{String($0)}
                    let i = NoteModel(
                        id: data.id,
                        coffeeName: data.coffee.name,
                        brand: data.coffee.brand,
                        drinkDate: "\(drinkStrings[0]) \(drinkStrings[1])",
                        sleepDate: "\(sleepStrings[0]) \(sleepStrings[1])",
                        comment: data.comment,
                        coffeeImgUrl: data.coffee.coffeeImgUrl,
                        createdAt: data.createdAt
                    )
                    
                    self.data.append(i)
                    
                }
                Task {
                    self.noteView.noteTableView.reloadData()
                }
                
            case .failure(let error):
                Toaster.shared.makeToast("\(error.errorDescription!)", .short)
            }
        }
    }
}

extension NoteMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        
        cell.configure(model: data[indexPath.row])
        
        if (indexPath.row == 0) {
            cell.last.isHidden = false
        } else {
            cell.last.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completion) in
            guard let self = self else { return }
            let deleteId = self.data[indexPath.row].id
            
            // 네트워크 요청
            self.networkService.deleteReview(reviewId: deleteId) { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.callGetAPI()
                        Toaster.shared.makeToast("기록이 삭제되었습니다.", .short)
                    case .failure(let error):
                        Toaster.shared.makeToast("\(error.errorDescription!)", .short)
                        Task {
                            self.noteView.noteTableView.reloadData()
                        }
                    }
                    completion(true) // 작업 완료
                }
            }
        }
        
        action.backgroundColor = .subColor
        if let trash = UIImage(named: "trash") {
            action.image = trash.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    // 셀이 선택되었을 때 호출되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = data[indexPath.row]
        handleCellTap(selectedItem)
    }
}
