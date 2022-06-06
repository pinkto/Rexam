//
//  AssessmentStatusView.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 05.06.2022.
//

import UIKit

final class AssessmentStatusView: UIView {
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "AssessmentStatusView", bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.backgroundColor = UIColor.clear
            addSubview(view)
            view.frame = self.bounds
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
    }
    
    func configure(with model: AssessmentStatusViewModel) {
        backgroundColor = model.status.backgroundColor
        statusImageView.image = model.status.image
        statusLabel.text = "\(model.questionCurrentRating) / \(model.questionMaximumRating)"
    }
}

struct AssessmentStatusViewModel {
    let status: AssesmentStatus
    let questionCurrentRating: Int
    let questionMaximumRating: Int
}
