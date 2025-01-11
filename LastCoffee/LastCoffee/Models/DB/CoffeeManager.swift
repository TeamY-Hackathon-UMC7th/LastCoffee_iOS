//
//  CoffeeManager.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import SwiftData
import UIKit

public final class CoffeeManager {
    public static let shared = CoffeeManager()
    
    lazy var container: ModelContainer = {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
            let container = try ModelContainer(
                for: CoffeeData.self,
                configurations: configuration
            )
            print("✅ SwiftData 초기화 성공!")
            return container
        } catch {
            print("❌ SwiftData 초기화 실패: \(error.localizedDescription)")
            fatalError("SwiftData 초기화 실패: \(error.localizedDescription)")
        }
    }()
    
    /// 커피 데이터를 저장하는 함수
    @MainActor
    public func saveCoffeeData(coffees: [CoffeeData]) async throws {
        let context = container.mainContext
        for coffee in coffees {
            context.insert(coffee)
        }
        do {
            try context.save()
            print("✅ \(coffees.count)개의 커피 데이터 저장 완료!")
        } catch {
            print("❌ 데이터 저장 중 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }

    /// 커피 데이터를 Fetch하는 함수
    @MainActor
    public func fetchCoffeeData() async throws -> [CoffeeData] {
        let context = container.mainContext
        let fetchRequest = FetchDescriptor<CoffeeData>()
        do {
            let result = try context.fetch(fetchRequest)
            print("✅ \(result.count)개의 커피 데이터 불러오기 성공!")
            return result
        } catch {
            print("❌ 데이터 불러오기 중 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }

    /// 모든 커피 데이터를 삭제하는 함수
    @MainActor
    public func deleteAllCoffeeData() async throws {
        let context = container.mainContext
        let fetchRequest = FetchDescriptor<CoffeeData>()
        do {
            let result = try context.fetch(fetchRequest)
            if result.isEmpty {
                print("⚠️ 삭제할 데이터가 없습니다.")
            } else {
                result.forEach { context.delete($0) }
                try context.save()
                print("✅ 모든 커피 데이터 삭제 완료!")
            }
        } catch {
            print("❌ 데이터 삭제 중 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
    
}

