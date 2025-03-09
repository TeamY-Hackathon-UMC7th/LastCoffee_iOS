//
//  AuthService.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation
import Moya

public final class AuthService : NetworkManager {
    typealias Endpoint = AuthEndpoint
    
    // MARK: - Provider 설정
    let provider: MoyaProvider<AuthEndpoint>
    
    public init(provider: MoyaProvider<AuthEndpoint>? = nil) {
        // 플러그인 추가
        let plugins: [PluginType] = [
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 로그 플러그인
        ]
        
        // provider 초기화
        self.provider = provider ?? MoyaProvider<AuthEndpoint>(plugins: plugins)
    }
    
    //MARK: - API funcs
    /// 로그인 DTO 생성 함수
    public func makeLoginDTO(name: String, email: String) -> LoginRequestDTO {
        return LoginRequestDTO(kakaoName: name, kakaoEmail: email)
    }
    
    /// 로그인 API
    public func postLoginAPI(data: LoginRequestDTO) async throws -> LoginResponseDTO {
        return try await requestAsync(target: .postLogin(data: data), decodingType: LoginResponseDTO.self)
    }
    
    /// 로그아웃 API
    public func postLogoutAPI() async throws -> String {
        return try await requestAsync(target: .postLogout)
    }
    
    /// 탈퇴 API
    public func deleteUserAPI() async throws -> String {
        return try await requestAsync(target: .deleteMember)
    }
    
    /// 닉네임 변경 (result 값이 확인 되지 않아서 수정 필요함!)
    public func patchNickname(nickname: String) async throws -> String {
        return try await requestAsync(target: .patchNickname(nickname: nickname))
    }
}
