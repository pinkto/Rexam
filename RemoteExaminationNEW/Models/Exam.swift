//
//  Exam.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

// MARK: - Exam

struct Exam: Codable {
    let id: Int
    let name: String
    let disciplineId: Int
    let groupId: Int
    let oneGroup: Bool
    let start, end: Int
    let state: String
}
