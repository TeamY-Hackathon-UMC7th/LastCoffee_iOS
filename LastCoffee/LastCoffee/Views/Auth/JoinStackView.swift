//
//  JoinStackView.swift
//  teamY
//
//  Created by 김도연 on 1/11/25.
//
import UIKit

public class JoinStackView: UIView {
    private let label = UILabel().then {
        $0.text = "라스트 커피가 처음이신가요?"
        $0.textColor = .black
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
    }
    
    private let joinButton = UIButton(type: .system).then {
        $0.setTitle("가입하기", for: .normal)
        $0.titleLabel?.font = UIFont.ptdMediumFont(ofSize: 14)
        $0.setTitleColor(.brown, for: .normal)
        $0.backgroundColor = .clear
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [label, joinButton]).then {
        $0.axis = .horizontal
        $0.spacing = 10 // 라벨과 버튼 사이 간격
        $0.alignment = .center
    }
    
    public init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 부모 뷰의 모든 가장자리에 맞춤
        }
    }
    
    func setJoinButtonAction(target: Any, action: Selector) {
        joinButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

