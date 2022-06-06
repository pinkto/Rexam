//
//  LoginResponse.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

// MARK: - LoginResponse

struct LoginResponse: Codable {
    let token: String
    let roles: String
}
