//
//  SearchBar.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit
import SnapKit
import Then

public class SearchBar: UITextField {
    
    public var placeholderText: String?
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        // 기본 플레이스홀더
        self.attributedPlaceholder = NSAttributedString(
            string: "메뉴명을 입력해주세요.",
            attributes: [
                .foregroundColor: UIColor(hex: "#8E8E8E") ?? .gray,
                .font: UIFont.ptdRegularFont(ofSize: 14)
            ]
        )
        self.textColor = .black
        self.tintColor = .mainColor
        self.font = UIFont.ptdRegularFont(ofSize: 14)
        
        let icon = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        imageView.image = icon
        imageView.tintColor = UIColor(hex: "#535353") ?? .gray
        imageView.contentMode = .scaleAspectFit
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        imageView.frame = CGRect(x: 7.6, y: 0, width: 24, height: 24)
        containerView.addSubview(imageView)
        
        self.leftView = containerView
        self.leftViewMode = .always
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.7
        self.layer.borderColor = UIColor(hex: "#535353")?.cgColor
        self.backgroundColor = UIColor(hex: "#FFFBF8")
        self.contentHorizontalAlignment = .left
        self.clearButtonMode = .whileEditing
    }
    
    public override func becomeFirstResponder() -> Bool {
        let didBecomeFirstResponder = super.becomeFirstResponder()
        if didBecomeFirstResponder {
            self.backgroundColor = UIColor(hex: "#FFFBF8")
            self.layer.borderWidth = 0.7
            self.layer.borderColor = UIColor.mainColor.cgColor
            self.imageView.tintColor = .mainColor
        }
        return didBecomeFirstResponder
    }
    
    public override func resignFirstResponder() -> Bool {
        let didResignFirstResponder = super.resignFirstResponder()
        if didResignFirstResponder {
            self.backgroundColor = UIColor(hex: "#FFFBF8")
            self.layer.borderWidth = 0.7
            self.layer.borderColor = UIColor(hex: "#535353")?.cgColor
            // 아이콘 색상 원래대로
            imageView.tintColor = UIColor(hex: "#535353")
        }
        return didResignFirstResponder
    }
}

