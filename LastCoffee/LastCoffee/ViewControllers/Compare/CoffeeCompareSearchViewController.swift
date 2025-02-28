//
//  CoffeeCompareSearchViewController.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit
import SwiftyToaster

class CoffeeCompareSearchViewController: UIViewController, UITextFieldDelegate {
    let networkService = CoffeeService()
    
    private var data: [CoffeeDetailResponse] = [
        CoffeeDetailResponse(id: 1, name: "아메리카노", brand: "스타벅스", sugar: 2, caffeine: 2, calories: 2, protein: 2, coffeeImgUrl: "https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B110563%5D_20210426095937947.jpg"),
        CoffeeDetailResponse(id: 2, name: "블루베리라떼", brand: "컴포즈", sugar: 3, caffeine: 3, calories: 2, protein: 1, coffeeImgUrl: "https://composecoffee.com/files/thumbnails/891/064/1515x2083.crop.jpg?t=1733793666"),
        CoffeeDetailResponse(id: 3, name: "유자티", brand: "컴포즈", sugar: 4, caffeine: 2, calories: 2, protein: 4, coffeeImgUrl: "https://composecoffee.com/files/thumbnails/682/038/1515x2083.crop.jpg?t=1733794981"),
    ]
    
    private var selectedIndexPath: IndexPath?
    public var fristSelectedDrink : CoffeeDetailResponse?
    private var selectedItem: CoffeeDetailResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = ""
        self.view = coffeeSearchView
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private lazy var coffeeSearchView: CompareSearchView = {
        let view = CompareSearchView()
        view.searchTableView.delegate = self
        view.searchTableView.dataSource = self
        view.searchBar.delegate = self
        view.nextBtn.addTarget(self, action: #selector(goAddView), for: .touchUpInside)
        return view
    }()

    @objc private func goAddView() {
        guard let first = fristSelectedDrink, let sec = selectedItem else { return }
        let resultVC = CompareResultViewController()
        if first.caffeine >= sec.caffeine {
            // 카페인 함량 많은 애가 무조건 앞에
            resultVC.coffees = [sec, first]
        } else {
            resultVC.coffees = [first, sec]
        }
        navigationController?.pushViewController(resultVC, animated: true)
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
        self.coffeeSearchView.searchTableView.reloadData()
        callPostAPI(coffeeSearchView.searchBar.text ?? "")
        return true
    }
    
    @objc func callPostAPI(_ keyword: String) {
        networkService.getSearchCoffee(keyword: keyword, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                data = response.coffees
                
                coffeeSearchView.searchTableView.isHidden = false
                coffeeSearchView.emptyLabel.isHidden = true
                
                coffeeSearchView.searchTableView.reloadData()
            case .failure(let error):
                Toaster.shared.makeToast("\(error.errorDescription!)", .short)
                coffeeSearchView.searchTableView.isHidden = true
                coffeeSearchView.emptyLabel.isHidden = false
            }
        }
        )
    }
}

extension CoffeeCompareSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteSearchCell.identifier, for: indexPath) as? NoteSearchCell else {
            return UITableViewCell()
        }
        
        cell.configure(model: data[indexPath.row])
        
        let searchText = coffeeSearchView.searchBar.text ?? ""
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
            coffeeSearchView.nextBtn.setEnabled(false)
            selectedItem = nil
            tableView.deselectRow(at: indexPath, animated: true)
            selectedIndexPath = nil
        } else {
            guard let cell = tableView.cellForRow(at: indexPath) as? NoteSearchCell else { return }
            cell.setSelectedBorder(isSelected: true)
            coffeeSearchView.nextBtn.setEnabled(true)
            selectedItem = data[indexPath.row]
            selectedIndexPath = indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NoteSearchCell else { return }
        cell.setSelectedBorder(isSelected: false)
        coffeeSearchView.nextBtn.setEnabled(false)
        selectedItem = nil
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = nil
    }
    
}
