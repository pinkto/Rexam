//
//  UIViewController+Ext.swift
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
    
    func showRetryAlert(
        message: String,
        onOkAction: (() -> ())? = nil,
        onRetryAction: (() -> ())? = nil
    ) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        if let onRetryAction = onRetryAction {
            alert.addAction(UIAlertAction(
                title: "Retry",
                style: .cancel,
                handler: { _ in
                    onRetryAction()
                }
            ))
        }
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                onOkAction?()
            }
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showUnderConstructionAlert() {
        let alert = UIAlertController(
            title: "Функционал в процессе разработки",
            message: nil,
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
