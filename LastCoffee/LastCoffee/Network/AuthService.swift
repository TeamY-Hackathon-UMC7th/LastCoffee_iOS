//
//  AuthService.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation
import Moya

public final class AuthService : NetworkManager {
    typealias Endpoint = AllEndpoint
    
    // MARK: - Provider 설정
    let provider: MoyaProvider<AllEndpoint>
    
    public init(provider: MoyaProvider<AllEndpoint>? = nil) {
        // 플러그인 추가
        let plugins: [PluginType] = [
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 로그 플러그인
        ]
        
        // provider 초기화
        self.provider = provider ?? MoyaProvider<AllEndpoint>(plugins: plugins)
    }
    
    //MARK: - API funcs
    /// 자체 로그인 API
    public func login(nickname: String, completion: @escaping (Result<LoginResponseDto, NetworkError>) -> Void) {
        request(target: .postLogin(nickname: nickname), decodingType: LoginResponseDto.self, completion: completion)
    }
    
    public func join(nickname: String, completion: @escaping (Result<JoinResponseDto, NetworkError>) -> Void) {
        request(target: .postSignup(nickname: nickname), decodingType: JoinResponseDto.self, completion: completion)
    }
    
    /// 닉네임 중복 체크 API
    public func checkEmail(nickname: String, completion: @escaping (Result<JoinResponseDto, NetworkError>) -> Void) {
        request(target: .checkNickname(nickname: nickname), decodingType: JoinResponseDto.self, completion: completion)
    }
}
