//
//  AuthEndpoint.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import UIKit
import Moya

public enum AuthEndpoint {
    case postEmail(email: String) // 이메일 중복 확인 및 인증
    case postJoin(data: JoinRequestDTO) // 회원가입
    case postLogin(data: LoginRequestDTO) // 로그인
    case postLogout // 로그아웃
    
    case patchNickname(nickname: String) // 닉네임 수정
    case reissueToken // 토큰 재발급
    case patchPassword(data: ChangePasswordRequestDTO) // 비밀번호 수정
    
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
        case .postEmail :
            return "/email"
        case .postJoin :
            return "/join"
        case .postLogout :
            return "/logout"
        case .postLogin :
            return "/login"
        case .patchPassword :
            return "/password/update"
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
        case .patchPassword :
            return .put
        case .deleteMember :
            return .delete
        default :
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .postEmail(let email) :
            return .requestParameters(parameters: ["email" : email], encoding: URLEncoding.queryString)
        case .postJoin(let data) :
            return .requestJSONEncodable(data)
        case .postLogout :
            return .requestPlain
        case .postLogin(let data) :
            return .requestJSONEncodable(data)
        case .patchPassword(let data) :
            return .requestJSONEncodable(data)
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
        case .patchPassword, .deleteMember, .postLogout:
            if let accessToken = LoginViewController.keychain.get("accessToken") {
                headers["Authorization"] = "Bearer \(accessToken)"
            }
        case .reissueToken:
            if let accessToken = LoginViewController.keychain.get("refreshToken") {
                headers["Authorization"] = "Bearer \(accessToken)"
            }
        default:
            break
        }
        return headers
    }
}

