//
//  CompareResultViewController.swift
//  LastCoffee
//
//  Created by 김도연 on 1/13/25.
//

import UIKit

class CompareResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var coffees : [CoffeeDetailResponse] = []
    var components : [Component] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "비교 결과"
        self.tabBarController?.isTabBarHidden = false
        viewSetting()
        setNavigationBar()
        setDrinkStack()
        decodingComponents()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func decodingComponents() {
        let f = coffees[0]
        let s = coffees[1]
        
        components = [
            Component(type: "카페인", unit: "mg", value1: f.caffeine, value2: s.caffeine),
            Component(type: "당", unit: "g", value1: f.sugar, value2: s.sugar),
            Component(type: "단백질", unit: "g", value1: f.protein, value2: s.protein),
            Component(type: "칼로리", unit: "kcal", value1: f.calories, value2: s.calories)
        ]
    }
    
    private lazy var coffeeResultView: CompareResultView = {
        let view = CompareResultView()
        return view
    }()
    
    private lazy var middleLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.2
        return view
    }()
    
    let tableView = UITableView().then {
        $0.register(ComponentCell.self, forCellReuseIdentifier: "ComponentCell")
        $0.allowsSelection = false
        $0.bounces = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    func setDrinkStack() {
        coffeeResultView.firstDrink.setDrinkInfo(image: coffees[0].coffeeImgUrl, brand: coffees[0].brand, name: coffees[0].name)
        coffeeResultView.secondDrink.setDrinkInfo(image: coffees[1].coffeeImgUrl, brand: coffees[1].brand, name: coffees[1].name)
        
        // 카페인 함량 같은지만 비교, 무조건 0번이 더 많거나 같음
        if coffees[0].caffeine == coffees[1].caffeine {
            coffeeResultView.setResult(isSame: true)
        } else {
            coffeeResultView.setResult(isSame: false)
        }
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewSetting() {
        view.backgroundColor = .background
        view.addSubview(coffeeResultView)
        view.addSubview(tableView)
        view.addSubview(middleLine)
        
        coffeeResultView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(200)
        }
        
        middleLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
            make.top.equalTo(coffeeResultView.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(middleLine.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell", for: indexPath) as? ComponentCell else {
            return UITableViewCell()
        }
        let coffee1Name = "[\(coffees[0].brand)] \(coffees[0].name)"
        let coffee2Name = "[\(coffees[1].brand)] \(coffees[1].name)"

        let c = components[indexPath.row]
        cell.configure(coffee1Name: coffee1Name, coffee2Name: coffee2Name, componentName: c.type, unit: c.unit, coffee1: c.value1, coffee2: c.value2)
        
        return cell
    }
}

public struct Component {
    let type: String
    let unit: String
    let value1 : Int
    let value2 : Int
    
    init(type: String, unit: String, value1: Int, value2: Int) {
        self.type = type
        self.unit = unit
        self.value1 = value1
        self.value2 = value2
    }
}

