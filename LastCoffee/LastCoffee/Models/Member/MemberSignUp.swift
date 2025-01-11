//
//  SignUpModel.swift
//  LastCoffee
//
//  Created by 이수현 on 1/12/25.
//

import Foundation


struct MemberSignUpRequest: Codable {
    let nickname: String
}

struct MemberSignUpResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
}
