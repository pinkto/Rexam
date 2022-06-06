//
//  TaskType.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 05.06.2022.
//

import Foundation

enum TaskType: String {
    case exercise = "EXERCISE"
    case question = "QUESTION"
    case unknown
    
    init(from value: String) {
        self = Self(rawValue: value) ?? .unknown
    }
}
