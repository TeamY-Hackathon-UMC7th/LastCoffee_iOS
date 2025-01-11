//
//  NoteMainViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteMainViewController: UIViewController {
    // 임시 데이터
    private let data: [NoteModel] = [
        NoteModel(coffeeName: "[스타벅스] 아이스 아메리카노", drinkingDate: "2025.01.11", drinkingTime: "00", sleepingDate: "2025.01.11", sleepingTime: "00", review: "2024년 7월 9일 오전 2시"),
        NoteModel(coffeeName: "[스타벅스] 카페라떼", drinkingDate: "2025.01.11", drinkingTime: "00", sleepingDate: "2025.01.11", sleepingTime: "00", review: "2024년 7월 9일 오전 2시"),
        NoteModel(coffeeName: "[스타벅스] 자바칩 프라푸치노", drinkingDate: "2025.01.11", drinkingTime: "00", sleepingDate: "2025.01.11", sleepingTime: "00", review: "2024년 7월 9일 오전 2시"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view = noteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.isNavigationBarHidden = true
        self.view = noteView
    }
    
    private lazy var noteView: NoteMainView = {
        let view = NoteMainView()
        view.noteTableView.delegate = self
        view.noteTableView.dataSource = self
        
        view.addBtn.addTarget(self, action: #selector(goSearchView), for: .touchUpInside)
        return view
    }()
    
    @objc private func goSearchView() {
        // let noteSearchVC = NoteSearchViewController()
        // navigationController?.pushViewController(noteSearchVC, animated: true)
    }

    // 셀 클릭 시 실행할 함수
    private func handleCellTap(_ item: NoteModel) {
        let noteDetailVC = NoteDetailViewController()
        noteDetailVC.receivedData = item
        navigationController?.pushViewController(noteDetailVC, animated: true)
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
