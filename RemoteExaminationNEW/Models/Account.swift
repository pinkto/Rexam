//
//  Account.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

// MARK: - Account

struct Account: Codable {
    let id: Int
    let username, name, surname: String
    let roles: [String]
}
