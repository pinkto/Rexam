//
//  ExamQuestionsListRequest.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

struct ExamQuestionsListRequest: Codable {
    let examId: Int
    let token: String
}
