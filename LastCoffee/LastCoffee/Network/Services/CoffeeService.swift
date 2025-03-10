//
//  CoffeeService.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation
import Moya

public final class CoffeeService : NetworkManager {
    typealias Endpoint = CoffeeEndpoint
    
    // MARK: - Provider 설정
    let provider: MoyaProvider<CoffeeEndpoint>
    
    public init(provider: MoyaProvider<CoffeeEndpoint>? = nil) {
        // 플러그인 추가
        let plugins: [PluginType] = [
            BearerTokenPlugin(),
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 로그 플러그인
        ]
        
        // provider 초기화
        self.provider = provider ?? MoyaProvider<CoffeeEndpoint>(plugins: plugins)
    }
    
    //MARK: - API funcs
    /// 커피 검색 API
    public func getSearchCoffee(keyword: String, page: Int) async throws -> SearchResponse {
        return try await requestAsync(target: .getSearchCoffee(keyword: keyword, page: page), decodingType: SearchResponse.self)
    }
    
    /// 시간대별 추천 커피 API
    public func getRecommendCoffees(time: Int) async throws -> [CoffeePreviewDTO] {
        return try await requestAsync(target: .getRecommendCoffee(time: time), decodingType: [CoffeePreviewDTO].self)
    }
    
    /// 최근에 추천받은 커피 API
    public func getRecentCoffees() async throws -> [CoffeePreviewDTO]? {
        return try await requestOptionalAsync(target: .getRecentCoffee, decodingType: [CoffeePreviewDTO].self)
    }
    
    /// 인기 커피 API
    public func getPopularCoffees() async throws -> [CoffeeDetailPreviewDTO] {
        return try await requestAsync(target: .getPopularCoffee, decodingType: [CoffeeDetailPreviewDTO].self)
    }
    
    /// 추천 음료 전부
    public func getAllRecommendCoffee(page: Int = 0, size: Int = 10) async throws -> [CoffeePreviewDTO] {
        return try await requestAsync(target: .getAllRecommendCoffee(page: page, size: size), decodingType: [CoffeePreviewDTO].self)
    }
}
