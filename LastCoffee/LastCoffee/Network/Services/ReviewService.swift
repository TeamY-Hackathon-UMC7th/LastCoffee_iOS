//
//  CoffeeService.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation
import Moya

public final class NoteService : NetworkManager {
    typealias Endpoint = NoteEndpoint
    
    // MARK: - Provider 설정
    let provider: MoyaProvider<NoteEndpoint>
    
    public init(provider: MoyaProvider<NoteEndpoint>? = nil) {
        // 플러그인 추가
        let plugins: [PluginType] = [
            BearerTokenPlugin(),
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 로그 플러그인
        ]
        
        // provider 초기화
        self.provider = provider ?? MoyaProvider<NoteEndpoint>(plugins: plugins)
    }
    
    //MARK: - API funcs

//    public func makeNewNoteDTO(writeDate: String, drinkDate: String, sleepDate: String, review: String, coffeeId: Int) -> NewNoteDTO {
//        return NewNoteDTO(writeDate: writeDate, drinkDate: drinkDate, drinkHour: <#T##String#>, drinkMinute: <#T##String#>, sleepDate: <#T##String#>, sleepHour: <#T##String#>, sleepMinute: <#T##String#>, review: <#T##String#>, coffeeId: <#T##Int#>)
//    }

}
