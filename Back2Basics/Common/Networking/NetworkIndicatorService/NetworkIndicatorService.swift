//
//  NetworkIndicatorService.swift
//  ARSkyline
//
//  Created by Adam Sterrett on 2/14/21.
//

import Foundation
import UIKit

class NetworkIndicatorService: NetworkIndicatorInterface {
    private var activityCount = 0
    private let queue = DispatchQueue(label: "NetworkActivityIndicatorQueue")

    var isVisible: Bool {
        return activityCount > 0
    }

    func incrementActivityCount() {
        queue.async {
            self.activityCount += 1
            self.handleCountUpdate()
        }
    }

    func decrementActivityCount() {
        queue.async {
            self.activityCount -= 1

            if self.activityCount < 0 {
                self.activityCount = 0
            }

            self.handleCountUpdate()
        }
    }
}

private extension NetworkIndicatorService {
    func handleCountUpdate() {
        DispatchQueue.main.async {
            if UIApplication.shared.isNetworkActivityIndicatorVisible != self.isVisible {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.isVisible
            }
        }
    }
}
