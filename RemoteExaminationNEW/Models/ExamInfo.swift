//
//  ExamInfo.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

// MARK: - ExamInfo

struct ExamInfo: Codable {
    let id: Int
    let semesterRating: Int
    let questionRating: Int
    let exerciseRating: Int
    let groupRatingId: Int
    let studentRatingState: String
    let exam: Exam
    let examRule: ExamRule
    let teacher: Teacher
}
