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
        default :
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        default :
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        let headers: [String: String] = [
            "Content-type": "application/json"
        ]
        return headers
    }
}
