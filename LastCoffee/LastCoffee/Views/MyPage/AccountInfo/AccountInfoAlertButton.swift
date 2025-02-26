//
//  AccountInfoAlertButton.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

enum AccountInfoAlertButtonType: String {
    case cancel = "취소"
    case confirm = "확인"
    case withdraw = "탈퇴"
}

class AccountInfoAlertButton: UIButton {
    private let type: AccountInfoAlertButtonType
    
    init(type: AccountInfoAlertButtonType) {
        self.type = type
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 6
        switch type {
        case .cancel:
            self.setTitle(type.rawValue, for: .normal)
            self.backgroundColor = UIColor(hex: "D4D4D4")
        case .confirm:
            self.setTitle(type.rawValue, for: .normal)
            self.backgroundColor = UIColor(hex: "592401")
        case .withdraw:
            self.setTitle(type.rawValue, for: .normal)
            self.backgroundColor = UIColor(hex: "FF2929")
        }
    }
}
