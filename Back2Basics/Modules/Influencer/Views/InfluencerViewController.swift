//
//  InfluencerViewController.swift
//  Back2Basics
//
//  Created by Adam Sterrett on 4/4/21.
//

import UIKit
import RxCocoa
import RxSwift

class InfluencerViewController: UIViewController {
                           
    private var viewModel: InfluencerViewModelInterface
    private let disposeBag = DisposeBag()
    private let alertController: AlertController
    @IBOutlet private weak var usernameLabel: UILabel!
    
    private let influencer: Influencer
    
    init(viewModel: InfluencerViewModelInterface, alertController: AlertController, activityIndicator: ActivityIndicator) {
        self.viewModel = viewModel
        self.influencer = viewModel.influencer
        self.alertController = alertController
        super.init(nibName: nil, bundle: nil)
    
        initViewModel()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Use init(viewModel:) instead")
    }
    
    required init?(coder aDecoder: NSCoder) {
         fatalError("Use init(viewModel:) instead")
     }
    
    @objc private func recenterMap(_ sender: Any) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setupUsernameLabel()
    }
    
    func setUpNavigationController() {
        let title = NSLocalizedString("Influencer_ViewController_Title", comment: "Screen title on the influencer navigation bar")
        self.navigationController?.setNavigationBarWithBackButton(in: self, title: title, target: self, action: #selector(openInfluencerView(_:)))
    }
    
    @objc private func openInfluencerView(_ sender: Any) {
        viewModel.closeInfluencerView()
    }
    
    func setupUsernameLabel()  {
        usernameLabel.text = "@\(String(describing: influencer.username))"
    }
    
}

private extension InfluencerViewController {
    func initViewModel() {

    }
}
