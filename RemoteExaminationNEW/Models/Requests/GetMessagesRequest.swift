//
//  GetMessagesRequest.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 05.06.2022.
//

import Foundation

struct GetMessagesRequest: Codable {
    let answerId: Int
    let token: String
}

struct GetMessagesPage: Codable {
    let page: Int
    let size: Int
    let sort: [String]
}
