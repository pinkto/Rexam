//
//  MessageCellView.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import UIKit

struct MessageViewCellModel {
    let title: String
    let message: String
    let time: String
}

final class MessageViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    func configure(with model: MessageViewCellModel) {
        titleLabel.text = model.title
        messageLabel.text = model.message
        timeLabel.text = model.time
    }
}
