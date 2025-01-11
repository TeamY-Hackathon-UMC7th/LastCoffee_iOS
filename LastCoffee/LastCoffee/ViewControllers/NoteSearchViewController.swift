//
//  NoteSearchViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit
import SwiftyToaster

class NoteSearchViewController: UIViewController, UITextFieldDelegate {
    let networkService = CoffeeService()
    
    // 임시 데이터
    private var data: [CoffeeDetailResponse] = []
    
    private var selectedIndexPath: IndexPath?
    private var selectedItem: CoffeeDetailResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "새 기록"
        self.view = noteSearchView
        self.tabBarController?.isTabBarHidden = true
    }
    
    private lazy var noteSearchView: NoteSearchView = {
        let view = NoteSearchView()
        view.noteSearchTableView.delegate = self
        view.noteSearchTableView.dataSource = self
        view.searchBar.delegate = self
        view.nextBtn.addTarget(self, action: #selector(goAddView), for: .touchUpInside)
        return view
    }()

    @objc private func goAddView() {
        let addNoteVC = AddNoteViewController()
        addNoteVC.receivedData = selectedItem
        navigationController?.pushViewController(addNoteVC, animated: true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.noteSearchView.noteSearchTableView.reloadData()
        callPostAPI(noteSearchView.searchBar.text ?? "")
        return true
    }
    
    @objc func callPostAPI(_ keyword: String) {
        networkService.getSearchCoffee(keyword: keyword, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                data = response.coffees
                noteSearchView.noteSearchTableView.reloadData()
            case .failure(let error):
                Toaster.shared.makeToast("\(error)", .short)
            }
        }
        )
    }
}

extension NoteSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteSearchCell.identifier, for: indexPath) as? NoteSearchCell else {
            return UITableViewCell()
        }
        
        cell.configure(model: data[indexPath.row])
        
        let searchText = noteSearchView.searchBar.text ?? ""
        cell.configure(model: data[indexPath.row], highlightText: searchText.isEmpty ? nil : searchText)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    // 셀 선택 시 테두리 활성화
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            guard let cell = tableView.cellForRow(at: indexPath) as? NoteSearchCell else { return }
            cell.setSelectedBorder(isSelected: false)
            noteSearchView.nextBtn.setEnabled(false)
            selectedItem = nil
            tableView.deselectRow(at: indexPath, animated: true)
            selectedIndexPath = nil
        } else {
            guard let cell = tableView.cellForRow(at: indexPath) as? NoteSearchCell else { return }
            cell.setSelectedBorder(isSelected: true)
            noteSearchView.nextBtn.setEnabled(true)
            selectedItem = data[indexPath.row]
            selectedIndexPath = indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NoteSearchCell else { return }
        cell.setSelectedBorder(isSelected: false)
        noteSearchView.nextBtn.setEnabled(false)
        selectedItem = nil
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = nil
    }
}
