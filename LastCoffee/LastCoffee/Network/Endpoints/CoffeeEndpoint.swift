//
//  CoffeeEndpoint.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import UIKit
import Moya

public enum CoffeeEndpoint {
    case getSearchCoffee(keyword: String, page: Int) // 음료 검색
    case getRecommendCoffee(time: Int) // 카페인 농도에 따른 음료 추천 (시간 대 추천)
    case getRecentCoffee // 최근 추천 받은 음료 5개?
    case getPopularCoffee // 인기 음료
    case getAllRecommendCoffee(page: Int, size: Int) // 추천 음료 전부
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
            return "/recommended/recent5"
        case .getPopularCoffee:
            return "/popular"
        case .getAllRecommendCoffee:
            return "/recommended/all"
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
        case .getAllRecommendCoffee(let page, let size):
            return .requestParameters(parameters: ["page" : page, "size" : size], encoding: URLEncoding.queryString)
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

