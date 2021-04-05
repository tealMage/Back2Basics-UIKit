//
//  HomeSplashScreen.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/11/21.
//

import UIKit

protocol HomeSplashScreenDelegate: class {
    func didSelectRetry(in view: HomeSplashScreen)
}

class HomeSplashScreen: UIView {
    @IBOutlet private weak var containerStackView: UIStackView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var retryButton: UIButton!

    weak var delegate: HomeSplashScreenDelegate?

    var message = "" {
        didSet {
            messageLabel.attributedText = NSAttributedString.multiLineLabel(with: message,
                                                                            font: FontStyle.primaryBold.font(size: 24.0),
                                                                            textColor: ColorStyle.grey37.color(),
                                                                            textAlignment: .center)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
}

private extension HomeSplashScreen {
    func commonInit() {
        loadViewFromNib()

        backgroundColor = ColorStyle.backgroundColor.color()

        setUpContainerView()
        setUpMessageLabel()
        setUpRetryButton()
    }

    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "HomeSplashScreen", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("HomeSplashScreen is unavailable")
        }

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)
    }

    func setUpContainerView() {
        containerStackView.spacing = 32.0
    }
    
    func setUpMessageLabel() {
        messageLabel.numberOfLines = 0
    }

    func setUpRetryButton() {
        let title = NSLocalizedString("Button_Try_Again", comment: "Retry button title")
        retryButton.setTitle(title, for: .normal)
        retryButton.titleLabel?.font = FontStyle.primaryBold.font(size: 16)

        retryButton.setTitleColor(ColorStyle.grey37.color(), for: .normal)
        retryButton.setTitleColor(ColorStyle.grey15.color(), for: .highlighted)

        retryButton.backgroundColor = .clear

        retryButton.layer.borderColor = ColorStyle.grey37.color().cgColor
        retryButton.layer.borderWidth = 1.0
        retryButton.layer.cornerRadius = 10
        
        retryButton.isAccessibilityElement = true
        retryButton.accessibilityIdentifier = "Home Retry Button"

        retryButton.addTarget(self, action: #selector(retryButtonTouchUpInside), for: .touchUpInside)
    }

    @objc func retryButtonTouchUpInside() {
        delegate?.didSelectRetry(in: self)
    }
}
