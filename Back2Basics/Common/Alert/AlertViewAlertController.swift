//
//  AlertViewAlertController.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
import UIKit

class AlertViewAlertController: AlertController {
    
    @objc func showOkAlertWithTitle(_ title: String?, message: String, presentingViewController: UIViewController, completion: VoidClosure?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: CommonString.ok.localizedString(), style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)

        self.showAlert(alert, fromViewController: presentingViewController)
    }
}

extension AlertViewAlertController {

    func showAlert(_ alert: UIAlertController, fromViewController: UIViewController) {
        DispatchQueue.main.async {
            fromViewController.present(alert, animated: true, completion: nil)
        }
    }
}
