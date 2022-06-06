//
//  ExaminationTicketViewCell.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 28.04.2022.
//

import UIKit

final class ExaminationTicketViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var assessmentStatusView: AssessmentStatusView!
    
    func configure(with model: ExaminationTicketViewCellModel) {
        titleLabel.text = model.title
        assessmentStatusView.configure(with: model.assessmentStatusModel)
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - ExaminationTicketViewCellModel

struct ExaminationTicketViewCellModel {
    let title: String
    let assessmentStatusModel: AssessmentStatusViewModel
}
