//
//  SendMessageRequest.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 05.06.2022.
//

import Foundation

struct SendMessageRequest: Codable {
    let answerId: Int
    let token: String
    let message: String
}
