//
//  ExamRule.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

// MARK: - ExamRule

struct ExamRule: Codable {
    let id: Int
    let name: String
    let duration: Int
    let minimalSemesterRating: Int
    let minimalExamRating: Int
    let maximumExamRating: Int
    let singleQuestionDefaultRating: Int
    let singleExerciseDefaultRating: Int
    let questionsRatingSum: Int
    let exercisesRatingSum: Int
    let disciplineId: Int
    let themeIds: [Int]
}
