//
//  MyPageView.swift
//  LastCoffee
//
//  Created by 이수현 on 2/24/25.
//

import UIKit

class MyPageView: UIView {
    
    // 스크롤 뷰
    private let scrollView = UIScrollView().then { view in
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    
    // 닉네임
    private let nicknameLabel = UILabel().then { lbl in
        lbl.text = "{닉네임}"
        lbl.font = .ptdMediumFont(ofSize: 22)
        lbl.textColor = .black
    }
    
    // 커피기록 / 추천 내역 스택 뷰
    private let topStackView = UIStackView().then { view in
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 11
    }
    
    // 커피 기록 뷰
    private let coffeRecordView = RecordInfoView(type: .coffeeRecord)
    
    // 추천 내역
    private let recommendRecordView = RecordInfoView(type: .recommendRecord)
    
    // 프로필 그룹
    private let profileGroupView = UIView()
    
    // 프로필
    private let profileLabel = UILabel().then { lbl in
        lbl.text = "프로필"
        lbl.font = .ptdSemiBoldFont(ofSize: 14)
        lbl.textColor = UIColor(hex: "8E8E8E")
    }
    // 계정 정보
    public let accountInfoView = MyPageLabel(type: .accountInfo)
    
    // 닉네임 변경
    public let changeNicknameView = MyPageLabel(type: .changeNickname)
    
    // 알림 설정
    public let alertSettingView = MyPageLabel(type: .alertSetting)
    
    // 분리선
    private let seperatorLineProfile = UIView().then { view in
        view.backgroundColor = UIColor(hex: "D9D9D9")
    }
    
    
    // 서비스 그룹
    private let serviceGroupView = UIView()
    
    // 서비스 이용
    private let serviceLabel = UILabel().then { lbl in
        lbl.text = "서비스 이용"
        lbl.font = .ptdSemiBoldFont(ofSize: 14)
        lbl.textColor = UIColor(hex: "8E8E8E")
    }
    
    // 다크모드 라벨
    private let darkModeLabel = UILabel().then { lbl in
        lbl.text = "다크 모드"
        lbl.font = .ptdSemiBoldFont(ofSize: 16)
        lbl.textColor = UIColor(hex: "2C2C2C")
    }
    
    // 스위치
    public let darkModeSwitch = UISwitch().then { sw in
    }
    
    // 분리선
    private let seperatorLineService = UIView().then { view in
        view.backgroundColor = UIColor(hex: "D9D9D9")
    }
    
    // 도움말 그룹
    private let helpGroupView = UIView()
    
    // 도움말
    private let helpLabel = UILabel().then { lbl in
        lbl.text = "도움말"
        lbl.font = .ptdSemiBoldFont(ofSize: 14)
        lbl.textColor = UIColor(hex: "8E8E8E")
    }
    
    // 개인정보처리방침
    public let personalInfoView = MyPageLabel(type: .personalInfo)
    
    // 서비스 이용 약관
    public let serviceInfoView = MyPageLabel(type: .serviceInfo)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .background
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            nicknameLabel,
            topStackView,
            profileGroupView,
            serviceGroupView,
            helpGroupView
        ].forEach{contentView.addSubview($0)}
        
        [
            coffeRecordView,
            recommendRecordView
        ].forEach{topStackView.addArrangedSubview($0)}
        
        [
            profileLabel,
            accountInfoView,
            changeNicknameView,
            alertSettingView,
            seperatorLineProfile
        ].forEach{profileGroupView.addSubview($0)}
        
        [
            serviceLabel,
            darkModeLabel,
            darkModeSwitch,
            seperatorLineService
        ].forEach{serviceGroupView.addSubview($0)}
        
        [
            helpLabel,
            personalInfoView,
            serviceInfoView
        ].forEach{helpGroupView.addSubview($0)}
    }
    
    private func setUI() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(57)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        // 프로필
        profileGroupView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        accountInfoView.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(18)
            make.horizontalEdges.equalToSuperview()
        }
        
        changeNicknameView.snp.makeConstraints { make in
            make.top.equalTo(accountInfoView.snp.bottom).offset(22)
            make.horizontalEdges.equalToSuperview()
        }
        
        alertSettingView.snp.makeConstraints { make in
            make.top.equalTo(changeNicknameView.snp.bottom).offset(22)
            make.horizontalEdges.equalToSuperview()
        }
        
        seperatorLineProfile.snp.makeConstraints { make in
            make.top.equalTo(alertSettingView.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(0.7)
        }
        
        // 서비스
        serviceGroupView.snp.makeConstraints { make in
            make.top.equalTo(profileGroupView.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        serviceLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        darkModeLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview()
            make.trailing.equalTo(darkModeSwitch.snp.leading)
        }
        
        darkModeSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(darkModeLabel)
        }
        
        seperatorLineService.snp.makeConstraints { make in
            make.top.equalTo(darkModeLabel.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(0.7)
        }
        
        // 도움말
        helpGroupView.snp.makeConstraints { make in
            make.top.equalTo(serviceGroupView.snp.bottom).offset(26)
            make.bottom.horizontalEdges.equalToSuperview().inset(16)
        }
        
        helpLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        personalInfoView.snp.makeConstraints { make in
            make.top.equalTo(helpLabel.snp.bottom).offset(18)
            make.horizontalEdges.equalToSuperview()
        }
        
        serviceInfoView.snp.makeConstraints { make in
            make.top.equalTo(personalInfoView.snp.bottom).offset(22)
            make.horizontalEdges.equalToSuperview()
        }
    }
}


