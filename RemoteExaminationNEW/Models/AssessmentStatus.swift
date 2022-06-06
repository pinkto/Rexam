//
//  AssessmentStatus.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 05.06.2022.
//

import UIKit

enum AssesmentStatus: String {
    case noAnswer = "NO_ANSWER"
    case inProgress = "IN_PROGRESS"
    case sent = "SENT"
    case checking = "CHECKING"
    case rated = "RATED"
    case noRating = "NO_RATING"
    case unknown
    
    init(from value: String) {
        self = Self(rawValue: value) ?? .unknown
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .noAnswer:
            return .systemGray
            
        case .inProgress:
            return .systemCyan
            
        case .sent:
            return .systemBlue
            
        case .checking:
            return .systemYellow
            
        case .rated:
            return .systemGreen
            
        case .noRating:
            return .systemRed
            
        case .unknown:
            return .systemGray
        }
    }
    
    var image: UIImage {
        switch self {
        case .noAnswer:
            return UIImage(named: "no_answer")!
            
        case .inProgress:
            return UIImage(named: "in_progress")!
            
        case .sent:
            return UIImage(named: "sent")!
            
        case .checking:
            return UIImage(named: "checking")!
            
        case .rated:
            return UIImage(named: "rated")!
            
        case .noRating:
            return UIImage(named: "no_rating")!
            
        case .unknown:
            return UIImage(named: "Exit")!
        }
    }
}
