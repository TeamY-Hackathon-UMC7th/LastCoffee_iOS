//
//  AlertSelectTimeViewController.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

class AlertSelectTimeViewController: UIViewController {
    private let hours = [
        "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12",
        "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"
    ]
    
    private var selectedHour = "16"
    private let selectTimeView = SelectTimeView(type: .inAlert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectTimeView.timePickerView.delegate = self
        self.selectTimeView.timePickerView.dataSource = self
        
        view = selectTimeView
        
        setNavigationBar()
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
        // 선택되어 있는 시간 설정
        let selectedHour = Int(LoginViewController.keychain.get(KeychainKey.alertTime.rawValue) ?? "16") ?? 16
        self.selectTimeView.timePickerView.selectRow(selectedHour, inComponent: 0, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
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
    
    // 확인 버튼 액션
    @objc private func touchUpInsideBtnNext() {
        // 알림 및 시간 저장
        LoginViewController.keychain.set(selectedHour, forKey: KeychainKey.alertTime.rawValue)
        self.navigationController?.popViewController(animated: true)
    }
}

extension AlertSelectTimeViewController: UIPickerViewDataSource {
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


extension AlertSelectTimeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hours[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedHour = hours[row]
    }
}
