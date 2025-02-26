//
//  Brand.swift
//  LastCoffee
//
//  Created by 주민영 on 2/26/25.
//

// 카페 브랜드 목록
enum Brand: CaseIterable, CustomStringConvertible {
    case all, starbucks, compose, paulBassett, baekDabang, hollys,
         megaCoffee, coffeeBean, ediya, banapresso, mammoth

    // 각 브랜드의 한글 이름 매핑
    var description: String {
        switch self {
        case .all: return "전체"
        case .starbucks: return "스타벅스"
        case .compose: return "컴포즈"
        case .paulBassett: return "폴바셋"
        case .baekDabang: return "빽다방"
        case .hollys: return "할리스"
        case .megaCoffee: return "메가커피"
        case .coffeeBean: return "커피빈"
        case .ediya: return "이디야"
        case .banapresso: return "바나프레소"
        case .mammoth: return "매머드"
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
