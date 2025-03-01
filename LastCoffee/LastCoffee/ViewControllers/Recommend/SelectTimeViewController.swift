//
//  SelectTimeViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import UIKit
import SwiftyToaster

class SelectTimeViewController: UIViewController {
    private let hours = [
        "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12",
        "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"
    ]
    
    private var selectedHour = "22"
    private let selectTimeView = SelectTimeView(type: .inRecommend)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectTimeView.timePickerView.delegate = self
        self.selectTimeView.timePickerView.dataSource = self
        self.selectTimeView.timePickerView.selectRow(22, inComponent: 0, animated: true)
        
        view = selectTimeView
        setNavigationBar()
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setAction() {
        selectTimeView.btnNext.addTarget(self, action: #selector(touchUpInsideBtnNext), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButton))
        leftBarButton.tintColor = .black
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    @objc private func popButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func touchUpInsideBtnNext() {
        let nextVC = RecommendDrinkViewController(selectedHour: selectedHour)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SelectTimeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}


extension SelectTimeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hours[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedHour = hours[row]
    }
}
