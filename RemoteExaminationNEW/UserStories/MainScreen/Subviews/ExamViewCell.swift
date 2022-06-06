//
//  ExamViewCell.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import UIKit

final class ExamViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timeStartLabel: UILabel!
    @IBOutlet var arrowMarkButton: UIButton!
    
    func configure(with model: ExamViewCellViewModel) {
        titleLabel.text = model.title
        scoreLabel.text = "Баллы: \(model.score)"
        timeStartLabel.text = model.timeStart
    }
}

// MARK: - ExamViewCellViewModel

struct ExamViewCellViewModel {
    let id: Int
    let title: String
    let score: Int
    let timeStart: String
}

// MARK: - Additional initializer for ExamViewCellViewModel

extension ExamViewCellViewModel {
    
    init(from info: ExamInfo) {
        self.id = info.exam.id
        self.title = info.exam.name
        self.score = info.semesterRating
                        + info.questionRating
                        + info.exerciseRating
        self.timeStart = DateFormatter.makeExamDate(from: info.exam.start)
    }
}
