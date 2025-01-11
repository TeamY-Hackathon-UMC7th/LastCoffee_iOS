//
//  CollectionViewSection.swift
//  LastCoffee
//
//  Created by 이수현 on 1/11/25.
//

import Foundation

enum Section: Hashable {
    case popularBanner(String)
    case recommmandBanner
    case flow(String)
}


enum Item: Hashable {
    case popularMenu(CoffeeDetailResponse)  // 아이템 모델 추가해야 함
    case recommendMenu(CoffeeDetailResponse)
    case flowMenu(CoffeeData)
}
