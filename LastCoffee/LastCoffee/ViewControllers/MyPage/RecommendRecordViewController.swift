//
//  RecommendRecordViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit
import SwiftyToaster

class RecommendRecordViewController: UIViewController {
    private let recommendRecordView = RecommendRecordView()
    private let coffeeService = CoffeeService()
    private var coffeeData = [CoffeePreviewDTO]()
    private var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = recommendRecordView
        
        setNavigationBar()
        setProtocol()
        getRecommendCoffee(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setProtocol() {
        recommendRecordView.tableView.dataSource = self
        recommendRecordView.tableView.delegate = self
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.title = "추천 내역"
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 추천 음료 API
    private func getRecommendCoffee(page: Int) {
        Task {
            do {
                let result = try await coffeeService.getAllRecommendCoffee(page: page)
                recommendRecordView.setComponent(isNilData: result.isEmpty)
                coffeeData = result
                recommendRecordView.tableView.reloadData()
            }
            catch {
                print(error.localizedDescription)
                Toaster.shared.makeToast("추천 내역이 없습니다.")
            }
        }
    }
}


extension RecommendRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendRecordCell.id, for: indexPath) as? RecommendRecordCell else { return UITableViewCell() }
        cell.config(coffeeData: coffeeData[indexPath.row])
        return cell
    }
}

extension RecommendRecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 마지막 셀에 도달하면 새로운 데이터를 로드
        if indexPath.row == coffeeData.count - 1 {
            page += 1
            getRecommendCoffee(page: page)
        }
    }
}
