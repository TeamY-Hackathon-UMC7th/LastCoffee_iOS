//
//  AuthEndpoint.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import UIKit
import Moya

public enum AuthEndpoint {
    case postLogin(data: LoginRequestDTO) // 로그인
    case postLogout // 로그아웃
    
    case patchNickname(nickname: String) // 닉네임 수정
    case reissueToken // 토큰 재발급
    
    case deleteMember // 회원탈퇴
}

extension AuthEndpoint: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: API.authURL) else {
            fatalError("authURL 오류")
        }
        return url
    }
    
    public var path: String {
        switch self {
        case .postLogout :
            return "/logout"
        case .postLogin :
            return "/login/kakao"
        case .patchNickname :
            return "/nickname/update"
        case .reissueToken :
            return "/reissue"
        case .deleteMember :
            return "/delete"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .deleteMember :
            return .delete
        case .patchNickname:
            return .patch
        default :
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .postLogin(let data) :
            return .requestJSONEncodable(data)
        case .postLogout :
            return .requestPlain
        case .patchNickname(let nickname) :
            return .requestParameters(parameters: ["nickname" : nickname], encoding: URLEncoding.queryString)
        case .reissueToken :
            return .requestPlain
        case .deleteMember :
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        var headers: [String: String] = [
            "Content-type": "application/json"
        ]
        
        switch self {
        case .deleteMember, .postLogout, .patchNickname:
            if let accessToken = TokenManager.shared.getAccessToken() {
                headers["Authorization"] = "Bearer \(accessToken)"
            }
        case .reissueToken:
            if let refreshToken = TokenManager.shared.getRefreshToken() {
                headers["Authorization"] = "Bearer \(refreshToken)"
            }
        default:
            break
        }
        return headers
    }
}

