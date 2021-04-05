//
//  StandardActivityIndicator.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/9/21.
//

import Foundation
import UIKit
class StandardActivityIndicator: ActivityIndicator {
    private let defaultBackgroundColor = UIColor.black.withAlphaComponent(0.1)

    private let blockingView: UIView
    private let activityIndicatorView: UIActivityIndicatorView
    private var isVisible = false

    var blockingViewBackroundColor: UIColor? {
        didSet {
            if let blockingViewBackroundColor = blockingViewBackroundColor {
                blockingView.backgroundColor = blockingViewBackroundColor
            } else {
                blockingView.backgroundColor = defaultBackgroundColor
            }
        }
    }

    var activityIndicatorColor: UIColor? {
        didSet {
            if let activityIndicatorColor = activityIndicatorColor {
                activityIndicatorView.color = activityIndicatorColor
            }
        }
    }

    init() {
        blockingView = UIView()
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

        blockingView.backgroundColor = defaultBackgroundColor
        blockingView.translatesAutoresizingMaskIntoConstraints = false
        blockingView.addSubview(activityIndicatorView)

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: blockingView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: blockingView.centerYAnchor).isActive = true
        activityIndicatorView.hidesWhenStopped = true
    }

    func show(in view: UIView?) {
        guard isVisible == false else {
            removeBlockingViewBeforeShowIfNeeded(from: view)
            return
        }

        isVisible = true

        DispatchQueue.main.async {
            let displayView = self.displayViewForView(view)
            displayView.addSubview(self.blockingView)

            self.blockingView.topAnchor.constraint(equalTo: displayView.topAnchor).isActive = true
            self.blockingView.bottomAnchor.constraint(equalTo: displayView.bottomAnchor).isActive = true
            self.blockingView.leadingAnchor.constraint(equalTo: displayView.leadingAnchor).isActive = true
            self.blockingView.trailingAnchor.constraint(equalTo: displayView.trailingAnchor).isActive = true

            self.blockingView.alpha = 0.0

            UIView.animate(withDuration: 0.3, animations: {
                self.blockingView.alpha = 1.0
            }, completion: { _ in
                self.activityIndicatorView.startAnimating()
            })
        }
    }

    func hide() {
        guard isVisible == true else { return }

        isVisible = false
        blockingView.alpha = 1.0

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.blockingView.alpha = 0.0
            }, completion: { _ in
                self.activityIndicatorView.stopAnimating()
                self.blockingView.removeFromSuperview()
            })
        }
    }
}

private extension StandardActivityIndicator {
    func removeBlockingViewBeforeShowIfNeeded(from view: UIView?) {
        let displayView = displayViewForView(view)

        DispatchQueue.main.async {
            if self.blockingView.superview == nil || self.blockingView.superview != displayView {
                self.blockingView.removeFromSuperview()
                self.isVisible = false
                self.show(in: view)
            }
        }
    }

    func displayViewForView(_ view: UIView?) -> UIView {
        
        if let view = view {
            return view
        } else {
            return UIApplication.shared.windows.first(where: {$0.isKeyWindow}) ?? UIWindow()
        }
    }
}
