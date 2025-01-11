//
//  NoteSearchViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteSearchViewController: UIViewController, UITextFieldDelegate {
    // 임시 데이터
    private let data: [NoteSearchModel] = [
        NoteSearchModel(image: UIImage(), name: "[스타벅스] 아이스 아메리카노"),
        NoteSearchModel(image: UIImage(), name: "[메가커피] 아이스 아메리카노")
    ]
    
    private var selectedIndexPath: IndexPath?
    private var selectedItem: NoteSearchModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "새 기록"
        self.view = noteSearchView
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
        /*
        let addNoteVC = AddNoteViewController()
        addNoteVC.receivedData = selectedItem
        navigationController?.pushViewController(addNoteVC, animated: true)
         */
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.noteSearchView.noteSearchTableView.reloadData()
        return true
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
