//
//  NoteMainViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteMainViewController: UIViewController {
    let networkService = ReviewService()
    // 임시 데이터
    private var data: [NoteModel] = [
        NoteModel(coffeeName: "헤이즐 넛 콜드브루", brand: "스타벅스", drinkDate: "2025-01-11 22:11",
              sleepDate: "2025-01-11 22:11", comment: "2024년 7월 9일 오전 2시", coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
        NoteModel(coffeeName: "헤이즐 넛 콜드브루", brand: "스타벅스", drinkDate: "2025-01-11 22:11",
                  sleepDate: "2025-01-11 22:11", comment: "2024년 7월 9일 오전 2시", coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
        NoteModel(coffeeName: "헤이즐 넛 콜드브루", brand: "스타벅스", drinkDate: "2025-01-11 22:11",
                  sleepDate: "2025-01-11 22:11", comment: "2024년 7월 9일 오전 2시", coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
        NoteModel(coffeeName: "헤이즐 넛 콜드브루", brand: "스타벅스", drinkDate: "2025-01-11 22:11",
                  sleepDate: "2025-01-11 22:11", comment: "2024년 7월 9일 오전 2시", coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
        NoteModel(coffeeName: "헤이즐 넛 콜드브루", brand: "스타벅스", drinkDate: "2025-01-11 22:11",
                  sleepDate: "2025-01-11 22:11", comment: "2024년 7월 9일 오전 2시", coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/[9200000002487]_20210426091745609.jpg"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.isTabBarHidden = false
        self.view = noteView
        callGetAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.isTabBarHidden = false
        self.view = noteView
        callGetAPI()
    }
    
    private lazy var noteView: NoteMainView = {
        let view = NoteMainView()
        view.noteTableView.delegate = self
        view.noteTableView.dataSource = self
        
        view.addBtn.addTarget(self, action: #selector(goSearchView), for: .touchUpInside)
        return view
    }()
    
    @objc private func goSearchView() {
        let noteSearchVC = NoteSearchViewController()
        navigationController?.pushViewController(noteSearchVC, animated: true)
    }

    // 셀 클릭 시 실행할 함수
    private func handleCellTap(_ item: NoteModel) {
        let noteDetailVC = NoteDetailViewController()
        noteDetailVC.receivedData = item
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
                    guard let drinkTimeString = convertISO8601ToCustomFormat(data.drinkTime) else {
                        return
                    }
                    guard let sleepTimeString = convertISO8601ToCustomFormat(data.sleepTime) else {return}
                    
                    let i = NoteModel(
                        coffeeName: data.coffee.name,
                        brand: data.coffee.brand,
                        drinkDate: drinkTimeString,
                        sleepDate: sleepTimeString,
                        comment: data.comment,
                        coffeeImgUrl: data.coffee.coffeeImgUrl
                    )
                    
                    self.data.append(i)
                }
                Task {
                    self.noteView.noteTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
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
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = .background
        action.image = UIImage(named: "trash")?.withTintColor(.subColor ?? .red)

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
