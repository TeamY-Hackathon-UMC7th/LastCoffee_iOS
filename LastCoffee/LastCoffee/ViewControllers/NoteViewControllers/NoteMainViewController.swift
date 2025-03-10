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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.view = noteView
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        callGetAPI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
    
    @objc private func goSearchView() {
        let noteSearchVC = NoteSearchViewController()
        navigationController?.pushViewController(noteSearchVC, animated: true)
    }

    // 셀 클릭 시 실행할 함수
    private func handleCellTap(_ item: NoteModel) {
        let noteDetailVC = NoteDetailViewController()
        noteDetailVC.receivedId = item.id
        noteDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    func callGetAPI() {
        Task {
            do {
                self.data.removeAll()
                startLoading()
                
                let reviews = try await networkService.getAllNoteList(page: 0).content
                guard let review = reviews else { return }
                
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
                stopLoading()
                DispatchQueue.main.async {
                    self.noteView.noteTableView.reloadData()
                }
            }
            catch {
                stopLoading()
                print(error.localizedDescription)
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
                let _ = try await networkService.deleteNote(noteId: deleteId)
                stopLoading()
                if let index = self.data.firstIndex(where: { $0.id == deleteId }) {
                    DispatchQueue.main.async {
                        self.data.remove(at: index)
                        let indexPath = IndexPath(row: index, section: 0)
                        self.noteView.noteTableView.deleteRows(at: [indexPath], with: .fade)
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
}
