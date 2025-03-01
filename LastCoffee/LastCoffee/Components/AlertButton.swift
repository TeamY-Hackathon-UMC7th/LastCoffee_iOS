//
//  AlertButtonType.swift
//  LastCoffee
//
//  Created by 이수현 on 2/25/25.
//

import UIKit

enum AlertButtonType: String {
    case cancel = "취소"
    case confirm = "확인"
    case withdraw = "탈퇴"
    case no = "아니요"
    case yes = "네"
}

class AlertButton: UIButton {
    private let type: AlertButtonType
    
    init(type: AlertButtonType) {
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
        self.setTitle(type.rawValue, for: .normal)
        switch type {
        case .cancel, .no: // 취소, 아니요
            self.backgroundColor = UIColor(hex: "D4D4D4")
        case .confirm, .yes: // 확인, 네
            self.backgroundColor = UIColor(hex: "592401")
        case .withdraw:
            self.backgroundColor = UIColor(hex: "FF2929")
        }
    }
}
