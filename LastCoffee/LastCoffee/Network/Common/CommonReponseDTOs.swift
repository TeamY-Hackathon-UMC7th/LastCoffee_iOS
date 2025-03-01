//
//  ApiResponse.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation

// 최상위 응답 모델
public struct ApiResponse<T: Decodable>: Decodable {
    public let isSuccess: Bool
    public let code: String
    public let message: String
    public let result: T?
}

