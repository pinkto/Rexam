//
//  UIViewControllerExt.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 23.05.2022.
//

import Foundation
import UIKit

public extension UIViewController {
    func showOKAlert(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        present(alert, animated: true, completion: nil)
    }
}
