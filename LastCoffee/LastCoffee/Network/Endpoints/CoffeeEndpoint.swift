//
//  CoffeeEndpoint.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import UIKit
import Moya

public enum CoffeeEndpoint {
    case getSearchCoffee(keyword: String, page: Int)
    case getRecommendCoffee(time: Int)
    case getRecentCoffee
    case getPopularCoffee
}

extension CoffeeEndpoint: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: API.coffeeURL) else {
            fatalError("coffeeURL 오류")
        }
        return url
    }
    
    public var path: String {
        switch self {
        case .getSearchCoffee:
            return "/search"
        case .getRecommendCoffee:
            return "/recommend"
        case .getRecentCoffee:
            return "/recent"
        case .getPopularCoffee:
            return "/popular"
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
        case .getSearchCoffee(let keyword, let page):
            return .requestParameters(parameters: ["keyword" : keyword, "page" : page], encoding: URLEncoding.queryString)
        case .getRecommendCoffee(let time):
            return .requestParameters(parameters: ["time" : time], encoding: URLEncoding.queryString)
        default :
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        var headers: [String: String] = [
            "Content-type": "application/json"
        ]
        return headers
    }
}

