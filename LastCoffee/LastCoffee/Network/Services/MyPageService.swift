//
//  MyPageService.swift
//  LastCoffee
//
//  Created by 이수현 on 3/2/25.
//

import Foundation
import Moya

public final class MyPageService : NetworkManager {
    typealias Endpoint = MyPageEndpoint
    
    // MARK: - Provider 설정
    let provider: MoyaProvider<MyPageEndpoint>
    
    public init(provider: MoyaProvider<MyPageEndpoint>? = nil) {
        // 플러그인 추가
        let plugins: [PluginType] = [
            BearerTokenPlugin(),
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 로그 플러그인
        ]
        
        // provider 초기화
        self.provider = provider ?? MoyaProvider<MyPageEndpoint>(plugins: plugins)
    }
    
    // 닉네임 반환 API
    public func getNickname() async throws -> String {
        return try await requestAsync(target: .getNickname, decodingType: String.self)
    }
    
    // 커피 기록 개수 API
    public func getCoffeeRecordCount() async throws -> Int {
        return try await requestAsync(target: .getCoffeeRecordCount, decodingType: Int.self)
    }
}
