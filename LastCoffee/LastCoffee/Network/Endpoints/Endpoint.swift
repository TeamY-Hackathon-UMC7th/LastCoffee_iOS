//
//  Endpoint.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import UIKit
import Moya

public enum AllEndpoint {
    case postSignup(nickname: String) // query
    case postLogin(nickname: String) // query
    case checkNickname(nickname: String) //path
    
    case getPopularCoffees
    case getRecommandCoffees(time: String)
    case getSearchCoffee(keyword: String)
    
    
    case getAllReviews
    case postReview(data: ReviewDto)
    case deleteReview(reviewId: Int)
    
}

extension AllEndpoint: TargetType {
    public var baseURL: URL {
        switch self {
        case .postSignup, .postLogin, .checkNickname:
            guard let url = URL(string: API.baseURL) else {
                fatalError("baseURL 오류")
            }
            return url
            // case 처리
        case .getPopularCoffees, .getRecommandCoffees, .getSearchCoffee:
            guard let url = URL(string: API.coffeeURL) else {
                fatalError("coffee url 오류")
            }
            return url
        case .postReview, .getAllReviews, .deleteReview:
            guard let url = URL(string: API.reviewURL) else {
                fatalError("review url 오류")
            }
            return url
        }
    }
    
    public var path: String {
        switch self {
        case .postLogin(_):
            return "/login"
        case .postSignup(_):
            return "/signup"
        case .checkNickname(let nickname):
            return "/check/\(nickname)"
        case .getPopularCoffees:
            return "/popular"
        case .getRecommandCoffees:
            return "/recommend"
        case .getSearchCoffee:
            return "/search"
        case .postReview, .getAllReviews:
            return ""
        case .deleteReview(let reviewId):
            return "/\(reviewId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .postLogin, .postSignup, .postReview:
            return .post
        case .deleteReview:
            return .delete
        default :
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .postSignup(let nickname):
            return .requestParameters(parameters: ["nickname" : nickname], encoding: URLEncoding.queryString)
        case .postLogin(let nickname):
            return .requestParameters(parameters: ["nickname" : nickname], encoding: URLEncoding.queryString)
        case .checkNickname(_):
            return .requestPlain
        case .getPopularCoffees:
            return .requestPlain
        case .getRecommandCoffees(let time):
            return .requestParameters(parameters: ["time" : time], encoding: URLEncoding.queryString)
        case .getSearchCoffee(let keyword):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.queryString)
        case .postReview(let data):
            return .requestJSONEncodable(data)
        case .getAllReviews, .deleteReview:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default :
            return ["Content-Type": "application/json"]
        }
    }
}

