//
//  RecommendRecordViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit

class RecommendRecordViewController: UIViewController {
    private let recommendRecordView = RecommendRecordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = recommendRecordView
        
        setNavigationBar()
        setProtocol()
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
}


extension RecommendRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendRecordCell.id, for: indexPath) as? RecommendRecordCell else { return UITableViewCell() }
        return cell
    }
}

extension RecommendRecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}
