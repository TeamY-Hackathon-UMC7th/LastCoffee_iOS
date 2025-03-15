//
//  Brand.swift
//  LastCoffee
//
//  Created by 주민영 on 2/26/25.
//

// 카페 브랜드 목록
enum Brand: String, CaseIterable, CustomStringConvertible {
    case all = "all"
    case mega = "mega"

    // 각 브랜드의 한글 이름 매핑
    var description: String {
        switch self {
        case .all: return "전체"
        case .mega: return "메가커피"
        }
    }

    // 전체 브랜드 목록을 반환
    static var allBrands: [Brand] {
        return Brand.allCases
    }

    // 전체 브랜드 이름 리스트를 반환
    static var allBrandNames: [String] {
        return allCases.map { $0.description }
    }
}
