//
//  ExaminationTicketViewCell.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 28.04.2022.
//

import UIKit

struct ExaminationTicketViewCellModel {
    let title: String
}

final class ExaminationTicketViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    func configure(with model: ExaminationTicketViewCellModel) {
        titleLabel.text = model.title
    }
}
