//
//  FileCellView.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import UIKit

struct FileViewCellModel {
    let title: String
    let image: UIImage
    let time: String
}

final class FileViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var fileLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var fileImageView: UIImageView!
    
    func configure(with model: FileViewCellModel) {
        titleLabel.text = model.title
        fileLabel.text = "Файл"
        timeLabel.text = model.time
        fileImageView.image = model.image
    }
}
