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
    public func makeLoginDTO(email: String, password: String) -> LoginRequestDTO {
        return LoginRequestDTO(email: email, password: password)
    }
    
    /// 회원가입 DTO 생성 함수
    public func makeJoinDTO(email: String, password: String) -> JoinRequestDTO {
        return JoinRequestDTO(email: email, password: password)
    }
    
    /// 비밀번호 변경 DTO 생성 함수
    public func updatePasswordDTO(curPassword: String, newPassword: String) -> ChangePasswordRequestDTO {
        return ChangePasswordRequestDTO(currentPassword: curPassword, updatePassword: newPassword)
    }
    
    /// 로그인 API
    public func postLoginAPI(data: LoginRequestDTO) async throws -> LoginResponseDTO {
        return try await requestAsync(target: .postLogin(data: data), decodingType: LoginResponseDTO.self)
    }
    
    
}
