//
//  SearchViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    let networkService = CoffeeService()
    
    private var data: [CoffeeDetailResponse] = []
    
    private var selectedIndexPath: IndexPath?
    private var selectedItem: CoffeeDetailResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view = searchView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.noteSearchTableView.delegate = self
        view.noteSearchTableView.dataSource = self
        view.searchBar.delegate = self
        return view
    }()
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchView.noteSearchTableView.reloadData()
        callPostAPI(searchView.searchBar.text ?? "")
        searchView.initLabel.isHidden = true
        return true
    }
    
    @objc func callPostAPI(_ keyword: String) {
        networkService.getSearchCoffee(keyword: keyword, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                data = response.coffees
                
                searchView.noteSearchTableView.isHidden = false
                searchView.emptyLabel.isHidden = true
                
                searchView.noteSearchTableView.reloadData()
            case .failure(let error):
                print(error)
                
                searchView.noteSearchTableView.isHidden = true
                searchView.emptyLabel.isHidden = false
            }
        }
        )
    }
    
    // 셀 클릭 시 실행할 함수
    private func handleCellTap(_ item: CoffeeDetailResponse) {
        let detailVC = DetailViewController()
        detailVC.receivedData = item
        detailVC.navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(detailVC, animated: true)
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
        
        let searchText = searchView.searchBar.text ?? ""
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
