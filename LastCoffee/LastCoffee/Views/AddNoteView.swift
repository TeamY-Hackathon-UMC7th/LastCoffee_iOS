//
//  AddNoteView.swift
//  LastCoffee
//
//  Created by 주민영 on 1/12/25.
//

import UIKit

class AddNoteView: UIView, UITextViewDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var selectedCoffeeIcon = UIImageView().then {
        $0.image = UIImage(named: "coffee-bean")
    }
    
    public lazy var selectedCoffee = UILabel().then {
        $0.font = UIFont.ptdMediumFont(ofSize: 14)
        $0.textColor = UIColor(hex: "#EE633A")
        $0.textAlignment = .left
        $0.text = "[스타벅스] 아이스 아메리카노"
    }
    
    private lazy var reviewTitle = UILabel().then {
        $0.font = UIFont.ptdMediumFont(ofSize: 16)
        $0.textColor = .mainColor
        $0.text = "후기"
    }
    
    let textViewPlaceHolder = "음료의 후기를 남겨주세요! (200자 제한)"
    
    public lazy var reviewTextView = UITextView().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 14)
        $0.textColor = .mainColor
        $0.textAlignment = .left
        $0.backgroundColor = UIColor(hex: "#FFFBF8")
        
        $0.isEditable = true
        $0.isScrollEnabled = true
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        $0.layer.borderColor = UIColor.mainColor?.cgColor
        $0.layer.borderWidth = 0.7
        $0.layer.cornerRadius = 10
        
        $0.text = textViewPlaceHolder
        $0.textColor = .lightGray
        $0.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = UIColor(hex: "#8E8E8E")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text.count
        if textCount > 200 {
            warningLabel.isHidden = false
            textView.layer.borderColor = UIColor(hex: "#FF2929")?.cgColor
            self.saveBtn.setEnabled(false)
        } else {
            warningLabel.isHidden = true
            textView.layer.borderColor = UIColor.mainColor?.cgColor
            self.saveBtn.setEnabled(true)
        }
    }
    
    private let warningLabel = UILabel().then {
        $0.text = "후기는 최대 200자까지 작성 가능합니다."
        $0.textColor = UIColor(hex: "#FF2929")
        $0.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.isHidden = true
    }

    public lazy var saveBtn = CustomButton(
        backgroundColor: .mainColor!,
        title: "저장하기",
        titleColor: .white,
        font: UIFont.ptdSemiBoldFont(ofSize: 18),
        radius: 10,
        isEnabled: true
    )

    public lazy var drinkingStack = createCustomStack(iconName: "coffee_fill", titleText: "마신 일시")
    public lazy var sleepingStack = createCustomStack(iconName: "moon", titleText: "취침 일시")
    
    public lazy var drinkingPicker = UIDatePicker().then {
        $0.datePickerMode = .dateAndTime
        $0.backgroundColor = .clear
        $0.locale = Locale(identifier: "ko_KR")
        $0.tintColor = .mainColor
    }
    
    public lazy var sleepingPicker = UIDatePicker().then {
        $0.datePickerMode = .dateAndTime
        $0.backgroundColor = .clear
        $0.locale = Locale(identifier: "ko_KR")
        $0.tintColor = .mainColor
    }
    
    private func setupView() {
        [
            selectedCoffeeIcon,
            selectedCoffee,
            drinkingStack,
            sleepingStack,
            drinkingPicker,
            sleepingPicker,
            reviewTitle,
            reviewTextView,
            warningLabel,
            saveBtn
        ].forEach {
            addSubview($0)
        }
        
        selectedCoffeeIcon.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(17)
            $0.leading.equalToSuperview().offset(34)
            $0.width.height.equalTo(18)
        }
        
        selectedCoffee.snp.makeConstraints {
            $0.leading.equalTo(selectedCoffeeIcon.snp.trailing).offset(6)
            $0.centerY.equalTo(selectedCoffeeIcon.snp.centerY)
        }
        
        drinkingStack.snp.makeConstraints {
            $0.top.equalTo(selectedCoffee.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(32)
        }
        
        sleepingStack.snp.makeConstraints {
            $0.top.equalTo(drinkingStack.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(32)
        }
        
        drinkingPicker.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-33)
            $0.centerY.equalTo(drinkingStack)
        }
        
        sleepingPicker.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-33)
            $0.centerY.equalTo(sleepingStack)
        }
        
        reviewTitle.snp.makeConstraints {
            $0.top.equalTo(sleepingStack.snp.bottom).offset(35)
            $0.leading.equalTo(sleepingStack.snp.leading)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(reviewTitle.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(33)
            $0.trailing.equalToSuperview().offset(-32)
            $0.height.equalTo(200)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(reviewTextView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(37)
        }
        
        saveBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-76)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(52)
        }
    }
    
    func createCustomStack(iconName: String, titleText: String) -> UIStackView {
        let icon = UIImageView().then {
            $0.image = UIImage(named: iconName)
            $0.contentMode = .scaleAspectFit
        }

        let title = UILabel().then {
            $0.font = UIFont.ptdMediumFont(ofSize: 16)
            $0.textColor = .mainColor
            $0.text = titleText
        }
        
        let stack = UIStackView(arrangedSubviews: [icon, title]).then {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        stack.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        icon.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }

        return stack
    }
}
