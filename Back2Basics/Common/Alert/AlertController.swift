//
//  AlertController.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
import UIKit
protocol AlertController {
    func showOkAlertWithTitle(_ title: String?,
                              message: String,
                              presentingViewController: UIViewController,
                              completion: VoidClosure?)

}
