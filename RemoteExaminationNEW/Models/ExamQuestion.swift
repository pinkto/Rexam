//
//  ExamQuestion.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

struct ExamQuestion: Codable {
    let id: Int
    let task: ExamQuestionTask
    let rating: Int
    let studentRatingId: Int
    let state: String
    let number: Int
}
