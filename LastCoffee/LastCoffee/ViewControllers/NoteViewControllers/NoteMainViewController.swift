//
//  NoteMainViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit
import SwiftyToaster

class NoteMainViewController: UIViewController {
    let networkService = NoteService()
    
    private var data: [NoteModel] = []
    
    var isLoading = false   // 중복 로딩 방지
    var totalPage = 0       // 전체 페이지 수
    var currentPage = 0     // 현재 페이지 번호
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.view = noteView
        setupDelegate()
        callGetAPI(startPage: 0)
        
        // 기록이 추가되면 메인뷰의 데이터를 다시 로드하기 위함
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshData),
            name: NSNotification.Name("NewNoteAdded"),
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
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
    
    // 기록 추가 - 검색뷰로 이동
    @objc private func goSearchView() {
        let noteSearchVC = NoteSearchViewController()
        navigationController?.pushViewController(noteSearchVC, animated: true)
    }

    // 셀 클릭 시 기록상세뷰로 이동
    private func handleCellTap(_ item: NoteModel) {
        let noteDetailVC = NoteDetailViewController()
        noteDetailVC.receivedId = item.id
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    // TODO:- 이거 페이지네이션이랑 새로 추가한 후에 다시 리로드되는거
    func callGetAPI(startPage: Int) {
        Task {
            do {
                self.isLoading = true
                startLoading()
                
                let result = try await networkService.getAllNoteList(page: startPage)
                
                if (result.currentPage == 0) {
                    self.data.removeAll()
                    self.totalPage = result.totalPage
                }
                guard let review = result.content else { return }
                self.currentPage = result.currentPage
                
                for data in review {
                    let i = NoteModel(
                        id: data.noteId,
                        brand: data.coffee.brand,
                        coffeeName: data.coffee.coffeeName,
                        coffeeImgUrl: data.coffee.coffeeImgUrl,
                        writeDate: data.writeDate,
                        drinkHour: data.drinkHour,
                        sleepHour: data.sleepHour
                    )
                    
                    self.data.append(i)
                }
                
                DispatchQueue.main.async {
                    self.noteView.noteTableView.reloadData()
                }
                
                self.stopLoading()
                self.isLoading = false
            }
            catch {
                self.stopLoading()
                self.isLoading = false
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func refreshData() {
        self.currentPage = 0
        self.totalPage = 0
        self.callGetAPI(startPage: 0)
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
    
    // 기록 삭제를 위한 메서드
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completion) in
            guard let self = self else { return }
            let deleteId = self.data[indexPath.row].id
            callDeleteAPI(deleteId: deleteId)
        }
        
        action.backgroundColor = .subColor
        if let trash = UIImage(named: "trash") {
            action.image = trash.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    // 삭제 API
    private func callDeleteAPI(deleteId: Int) {
        Task {
            do {
                startLoading()
                _ = try await networkService.deleteNote(noteId: deleteId)
                
                stopLoading()
                if let index = self.data.firstIndex(where: { $0.id == deleteId }) {
                    DispatchQueue.main.async {
                        self.noteView.noteTableView.performBatchUpdates({
                            self.data.remove(at: index)
                            let indexPath = IndexPath(row: index, section: 0)
                            self.noteView.noteTableView.deleteRows(at: [indexPath], with: .fade)
                        }) { _ in
                            self.noteView.noteTableView.reloadData()
                        }
                    }
                }
                print("기록이 삭제되었습니다.")
            } catch {
                stopLoading()
                print(error)
            }
        }
    }
    
    // 셀이 선택되었을 때 호출되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = data[indexPath.row]
        handleCellTap(selectedItem)
    }
    
    // 페이지네이션을 위한 메서드
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.frame.size.height

        if offsetY > contentHeight - tableViewHeight {
            guard !isLoading, currentPage + 1 < totalPage else { return }
            callGetAPI(startPage: currentPage + 1)
        }
    }
}
