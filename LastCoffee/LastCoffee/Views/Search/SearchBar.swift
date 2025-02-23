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
    private let leftImageView = UIImageView()
    private let rightImageView = UIImageView()
    
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
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.7
        self.layer.borderColor = UIColor(hex: "#535353")?.cgColor
        self.backgroundColor = UIColor(hex: "#FFFBF8")
        self.contentHorizontalAlignment = .left
        self.clearButtonMode = .never
        
        // 왼쪽 아이콘 설정
        let leftIcon = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        leftImageView.image = leftIcon
        leftImageView.tintColor = UIColor(hex: "#535353") ?? .gray
        leftImageView.contentMode = .scaleAspectFit
        
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 24))
        leftImageView.frame = CGRect(x: 12, y: 0, width: 24, height: 24)
        leftContainerView.addSubview(leftImageView)
        
        self.leftView = leftContainerView
        self.leftViewMode = .always
        
        // 오른쪽 아이콘 설정
        let rightIcon = UIImage(named: "x")?.withRenderingMode(.alwaysTemplate)
        rightImageView.image = rightIcon
        rightImageView.tintColor = UIColor(hex: "#8E8E8E") ?? .gray
        rightImageView.contentMode = .scaleAspectFit
        
        let rightContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 24))
        rightImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        rightContainerView.addSubview(rightImageView)
        
        self.rightView = rightContainerView
        self.rightViewMode = .whileEditing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clearTextField))
        self.rightView?.addGestureRecognizer(tapGesture)
    }
    
    @objc func clearTextField() {
        self.text = ""
    }
    
    public override func becomeFirstResponder() -> Bool {
        let didBecomeFirstResponder = super.becomeFirstResponder()
        if didBecomeFirstResponder {
            self.backgroundColor = UIColor(hex: "#FFFBF8")
            self.layer.borderWidth = 0.7
            self.layer.borderColor = UIColor.mainColor?.cgColor
            self.leftImageView.tintColor = .mainColor
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
            leftImageView.tintColor = UIColor(hex: "#535353")
        }
        return didResignFirstResponder
    }
}

