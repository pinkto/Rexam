//
//  ExamQuestionTask.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

struct ExamQuestionTask: Codable {
    let id: Int
    let text: String
    let taskType: String
    let themeName: String
}
