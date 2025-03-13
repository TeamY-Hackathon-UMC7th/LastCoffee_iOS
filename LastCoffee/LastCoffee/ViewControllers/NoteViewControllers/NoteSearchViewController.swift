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
    
    var isLoading = false   // 중복 로딩 방지
    var totalPage = 0       // 전체 페이지 수
    var currentPage = 0     // 현재 페이지 번호

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = noteSearchView
        self.navigationController?.navigationBar.isHidden = false
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

    // 기록 추가뷰로 이동
    @objc private func goAddView() {
        let addNoteVC = AddNoteViewController()
        addNoteVC.receivedData = selectedItem
        navigationController?.pushViewController(addNoteVC, animated: true)
    }
    
    // 네비게이션바 설정
    private func setNavigationBar() {
        self.navigationItem.title = "새 기록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.ptdMediumFont(ofSize: 18)]
        let leftBarButton = UIBarButtonItem(image: .init(named: "Back"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func callSearchAPI(keyword: String, startPage: Int) {
        Task {
            do {
                self.isLoading = true
                startLoading()
                
                let result = try await networkService.getSearchCoffee(keyword: keyword, page: startPage)
                
                if (result.isFirst) {
                    self.data = result.coffeeResponseDtos
                    self.totalPage = result.totalPages
                } else {
                    self.data.append(contentsOf: result.coffeeResponseDtos)
                }
                self.currentPage = result.currentPage
                
                DispatchQueue.main.async {
                    self.noteSearchView.noteSearchTableView.reloadData()
                    self.noteSearchView.emptyLabel.isHidden = !self.data.isEmpty
                }
                
                stopLoading()
                self.isLoading = false
            }
            catch {
                self.stopLoading()
                self.isLoading = false
                print(error.localizedDescription)
            }
        }
    }
    
    // 텍스트필드에서 엔터를 누를 시 실행되는 메서드
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            // 테이블뷰의 맨 위로 이동하게함
            self.noteSearchView.noteSearchTableView.setContentOffset(.zero, animated: true)
        }
        callSearchAPI(keyword: noteSearchView.searchBar.text ?? "", startPage: 0)
        textField.resignFirstResponder()
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
    
    // 선택된 셀 선택 시 테두리 비활성화
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NoteSearchCell else { return }
        cell.setSelectedBorder(isSelected: false)
        noteSearchView.nextBtn.setEnabled(false)
        selectedItem = nil
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = nil
    }
    
    // 페이지네이션을 위한 메서드
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.frame.size.height

        if offsetY > contentHeight - tableViewHeight {
            guard !isLoading, currentPage + 1 < totalPage else { return }
            callSearchAPI(keyword: noteSearchView.searchBar.text ?? "", startPage: currentPage + 1)
        }
    }
}
