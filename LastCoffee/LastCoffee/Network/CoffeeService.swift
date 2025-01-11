//
//  CoffeeService.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation
import Moya

public final class CoffeeService : NetworkManager {
    typealias Endpoint = AllEndpoint
    
    // MARK: - Provider 설정
    let provider: MoyaProvider<AllEndpoint>
    
    public init(provider: MoyaProvider<AllEndpoint>? = nil) {
        // 플러그인 추가
        let plugins: [PluginType] = [
            BearerTokenPlugin(),
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 로그 플러그인
        ]
        
        // provider 초기화
        self.provider = provider ?? MoyaProvider<AllEndpoint>(plugins: plugins)
    }
    
    //MARK: - API funcs
    /// 인기 커피 불러오기
    public func getPopularCoffee(completion: @escaping (Result<CoffeeFirstDTO, NetworkError>) -> Void) {
        request(target: .getPopularCoffees, decodingType: CoffeeFirstDTO.self, completion: completion)
    }
    
    public func getRecommandCoffee(time: String, completion: @escaping (Result<CoffeeFirstDTO, NetworkError>) -> Void) {
        request(target: .getRecommandCoffees(time: time), decodingType: CoffeeFirstDTO.self, completion: completion)
    }
    
    public func getSearchCoffee(keyword: String, completion: @escaping (Result<CoffeeFirstDTO, NetworkError>) -> Void) {
        request(target: .getSearchCoffee(keyword: keyword), decodingType: CoffeeFirstDTO.self, completion: completion)
    }
    
    
    

}
