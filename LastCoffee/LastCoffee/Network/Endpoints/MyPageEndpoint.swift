//
//  MyPageEndpoint.swift
//  LastCoffee
//
//  Created by 이수현 on 3/2/25.
//

import UIKit
import Moya

public enum MyPageEndpoint {
    case getNickname // 닉네임 반환
    case getCoffeeRecordCount // 커피 기록 개수
}

extension MyPageEndpoint: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: API.myPageURL) else {
            fatalError("myPageURL 오류")
        }
        return url
    }
    
    public var path: String {
        switch self {
        case .getNickname:
            return "nickname"
        case .getCoffeeRecordCount:
            return "howmanycoffee"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getNickname, .getCoffeeRecordCount:
                .get
        }
    }
    
    public var task: Moya.Task {
        .requestPlain
    }
    
    public var headers: [String : String]? {
        var headers: [String: String] = [
            "Content-type": "application/json"
        ]
        
        switch self {
        case .getNickname, .getCoffeeRecordCount:
            if let accessToken = LoginViewController.keychain.get("accessToken") {
                headers["Authorization"] = "Bearer \(accessToken)"
            }
        }
        return headers
    }
}
