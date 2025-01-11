//
//  Request.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation

public struct TimeRequestDto : Codable {
    public var userTimeInput: String
    
    public init(userTimeInput: String) {
        self.userTimeInput = userTimeInput
    }
}

