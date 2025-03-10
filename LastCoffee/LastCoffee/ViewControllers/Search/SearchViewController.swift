//
//  SearchViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    let networkService = CoffeeService()
    let brandData = Brand.allBrands
    
    var selectedBrands: [Brand] = []
    private var data: [CoffeeDetailDTO] = []
    
    private var selectedIndexPath: IndexPath?
    private var selectedItem: CoffeeDetailResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.view = searchView
        setupDelegate()
        
        let defaultIndexPath = IndexPath(item: 0, section: 0)
        searchView.brandCollectionView.selectItem(at: defaultIndexPath, animated: false, scrollPosition: [])
        selectedBrands.append(brandData[0])
        
        callSearchAPI(keyword: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        return view
    }()
    
    private func setupDelegate() {
        searchView.brandCollectionView.delegate = self
        searchView.brandCollectionView.dataSource = self
        searchView.noteSearchTableView.delegate = self
        searchView.noteSearchTableView.dataSource = self
        searchView.searchBar.delegate = self
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchView.noteSearchTableView.reloadData()
        callSearchAPI(keyword: searchView.searchBar.text ?? "")
        return true
    }
    
    func callSearchAPI(keyword: String) {
        Task {
            do {
                startLoading()
                let data = try await networkService.getSearchCoffee(keyword: keyword, page: 0).coffeeResponseDtos
                self.data = data
                
                stopLoading()
                DispatchQueue.main.async {
                    self.searchView.noteSearchTableView.reloadData()
                }
            }
            catch {
                stopLoading()
                print(error.localizedDescription)
            }
        }
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
    
    // 셀 클릭 시 상세뷰로 이동하는 함수
    private func handleCellTap(_ item: CoffeeDetailDTO) {
        let detailVC = SearchDetailViewController()
        detailVC.receivedData = item
        detailVC.navigationController?.navigationBar.isHidden = false
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipButtonCell.identifier, for: indexPath) as! ChipButtonCell
        cell.configure(brand: brandData[indexPath.row].description, tag: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
           selectedIndexPaths.contains(indexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            return false
        }
        return true
    }
    
    // 셀 선택 시 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 만약 "전체" 버튼을 탭한 경우, 다른 모든 셀 deselect
        if indexPath.item == 0 {
            if let selectedItems = collectionView.indexPathsForSelectedItems {
                for ip in selectedItems where ip.item != 0 {
                    collectionView.deselectItem(at: ip, animated: false)
                    if let idx = selectedBrands.firstIndex(of: brandData[ip.item]) {
                        selectedBrands.remove(at: idx)
                    }
                }
            }
            // "전체"가 선택되어 있지 않다면 추가
            if !selectedBrands.contains(brandData[0]) {
                selectedBrands.append(brandData[0])
            }
        } else { // "전체"가 아닌 다른 버튼을 탭한 경우
            // 만약 "전체" 버튼이 선택되어 있다면, deselect 처리
            let allIndexPath = IndexPath(item: 0, section: 0)
            if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.contains(allIndexPath) {
                collectionView.deselectItem(at: allIndexPath, animated: false)
                if let idx = selectedBrands.firstIndex(of: brandData[0]) {
                    selectedBrands.remove(at: idx)
                }
            }
            // 선택된 브랜드 추가 (중복 체크)
            let brand = brandData[indexPath.item]
            if !selectedBrands.contains(brand) {
                selectedBrands.append(brand)
            }
        }
        print("현재 선택된 브랜드: \(selectedBrands)")
    }
    
    // 셀 선택 해제 시 동작
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let brand = brandData[indexPath.item]
        if let idx = selectedBrands.firstIndex(of: brand) {
            selectedBrands.remove(at: idx)
        }
        // 만약 선택된 항목이 없다면 자동으로 "전체" 버튼을 선택
        if selectedBrands.isEmpty {
            let allIndexPath = IndexPath(item: 0, section: 0)
            collectionView.selectItem(at: allIndexPath, animated: false, scrollPosition: .left)
            selectedBrands.append(brandData[0])
        }
        print("현재 선택된 브랜드: \(selectedBrands)")
    }
}
