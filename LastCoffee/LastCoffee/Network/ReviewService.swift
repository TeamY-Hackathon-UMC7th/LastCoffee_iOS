//
//  CoffeeService.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation
import Moya

public final class ReviewService : NetworkManager {
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
    public func makeReviewDto(coffeeKey: Int, comment: String, drinkTime: Date, sleepTime: Date) -> ReviewDto {
        return ReviewDto(coffeeKey: coffeeKey, comment: comment,
                         drinkTime: convertDateToISO8601(drinkTime), sleepTime: convertDateToISO8601(sleepTime))
    }
    
    public func postReview(reviewDto: ReviewDto, completion: @escaping (Result<String, NetworkError>) -> Void) {
        request(target: .postReview(data: reviewDto), decodingType: String.self, completion: completion)
    }

    /// 인기 커피 불러오기
    public func getReviews(completion: @escaping (Result<[Review], NetworkError>) -> Void) {
        request(target: .getAllReviews, decodingType: [Review].self, completion: completion)
    }
    

}
