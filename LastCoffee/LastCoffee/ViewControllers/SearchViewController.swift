//
//  SearchViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    // 임시 데이터
    private let data: [NoteSearchModel] = [
        NoteSearchModel(image: UIImage(), name: "[스타벅스] 아이스 아메리카노"),
        NoteSearchModel(image: UIImage(), name: "[메가커피] 아이스 아메리카노")
    ]
    
    private var selectedIndexPath: IndexPath?
    private var selectedItem: NoteSearchModel?
    public var selectedFilter: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = searchView
        self.navigationController?.isNavigationBarHidden = false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchView.noteSearchTableView.reloadData()
        return true
   }
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        setDelegate()
        
        view.totalBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.starbucksBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.composeBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        return view
    }()
    
    private func setDelegate() {
        searchView.noteSearchTableView.delegate = self
        searchView.noteSearchTableView.dataSource = self
        searchView.searchBar.delegate = self
    }
    
    @objc private func buttonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        switch sender.tag {
        case 1:
            selectedFilter = "전체"
        case 2:
            selectedFilter = "스타벅스"
        case 3:
            selectedFilter = "컴포즈커피"
        default:
            selectedFilter = nil
        }
        
        if sender.isSelected {
            sender.backgroundColor = .mainColor
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderWidth = 0
        } else {
            sender.backgroundColor = UIColor(hex: "#FFF9F4")
            sender.setTitleColor(UIColor(hex: "#767676"), for: .normal)
            sender.layer.borderWidth = 0.7
        }
    }
    
    // 셀 클릭 시 실행할 함수
    private func handleCellTap(_ item: NoteSearchModel) {
        let noteDetailVC = DetailViewController()
        noteDetailVC.receivedData = item
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteSearchCell.identifier, for: indexPath) as? NoteSearchCell else {
            return UITableViewCell()
        }
        
        let searchText = searchView.searchBar.text ?? "empty"
        cell.configure(model: data[indexPath.row], highlightText: searchText.isEmpty ? nil : searchText)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
     // 셀이 선택되었을 때 호출되는 메서드
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedItem = data[indexPath.row]
         print("선택된 항목: \(selectedItem)")
         handleCellTap(selectedItem)
     }
}



