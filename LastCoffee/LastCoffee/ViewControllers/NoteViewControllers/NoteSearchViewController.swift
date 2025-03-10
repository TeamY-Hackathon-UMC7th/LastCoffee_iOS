//
//  NoteSearchViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class NoteSearchViewController: UIViewController, UITextFieldDelegate {
    let networkService = CoffeeService()
    
    private var data: [CoffeeDetailDTO] = []
    
    private var selectedIndexPath: IndexPath?
    private var selectedItem: CoffeeDetailDTO?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "새 기록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.ptdMediumFont(ofSize: 18)]
        self.view = noteSearchView
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBar()
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
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(named: "Back"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.noteSearchView.noteSearchTableView.reloadData()
        callSearchAPI(keyword: noteSearchView.searchBar.text ?? "")
        return true
    }
    
    private func callSearchAPI(keyword: String) {
        Task {
            do {
                self.data.removeAll()
                let coffees = try await networkService.getSearchCoffee(keyword: keyword, page: 0).coffeeResponseDtos
                self.data = coffees
                
                DispatchQueue.main.async {
                    self.noteSearchView.noteSearchTableView.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
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
