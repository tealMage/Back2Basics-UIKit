//
//  HomeViewController.swift
//  arskyline
//
//  Created by Adam Sterrett on 2/9/21.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    private var viewModel: HomeViewModelInterface
    private let disposeBag = DisposeBag()
    private let alertController: AlertController
    private let activityIndicator: ActivityIndicator

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var splashScreen: HomeSplashScreen!

    private var rowItems: [Influencer] = []
    
    init(viewModel: HomeViewModelInterface, alertController: AlertController, activityIndicator: ActivityIndicator) {
        self.viewModel = viewModel
        self.alertController = alertController
        self.activityIndicator = activityIndicator

        super.init(nibName: nil, bundle: nil)

        initViewModel()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Use init(viewModel:) instead")
    }

    required init?(coder aDecoder: NSCoder) {
         fatalError("Use init(viewModel:) instead")
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSplashScreen()
        setUpTableView()
    }

    func setUpNavigationController() {
        let title = NSLocalizedString("Home_ViewController_Title", comment: "Screen title on the home navigation bar")
        self.navigationController?.setNavigationBarWithTitle(in: self, title: title)
    }

    func setUpSplashScreen() {
        splashScreen.delegate = self
        splashScreen.alpha = 0.0
    }

    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = ColorStyle.clear.color()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")

        registerCells()
    }

    func registerCells() {
        let bannerWidgetCellNib = UINib(nibName: "InfluencerCell", bundle: nil)
        tableView.register(bannerWidgetCellNib, forCellReuseIdentifier: InfluencerCell.cellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigationController()
        viewModel.refreshData()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectInfluencer(rowItems[indexPath.row], viewController: self)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return influencerCell(at: indexPath)
    }
    
    func influencerCell(at indexPath: IndexPath) -> InfluencerCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfluencerCell.cellIdentifier, for: indexPath) as? InfluencerCell else {
            fatalError("The influencerCell is missing.")
        }

        cell.influencer = rowItems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

private extension HomeViewController {
    func initViewModel() {
        setUpFetchHomeResult()
    }
        
    func setUpFetchHomeResult() {

        viewModel.influencerFetchResult
            .asObservable()
            .observe(on: MainScheduler())
            .withUnretained(self)
            .subscribe(onNext: { owner, result in

                switch result {
                case .loading:
                    owner.activityIndicator.show(in: owner.view)
                
                case .loaded(let influencers):
                    owner.activityIndicator.hide()
                    self.rowItems = influencers
                    self.tableView.reloadData()
                case .failed(let message):
                    owner.alertController.showOkAlertWithTitle(NSLocalizedString("Error", comment: "Indicating a mistake has been made"), message: message, presentingViewController: self) {
                    }
                    owner.activityIndicator.hide()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showErrorMessage(_ message: String?) {
        let visible = message != nil
        self.splashScreen.message = message ?? ""
        
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.alpha = visible ? 0.0 : 1.0
            self.splashScreen.alpha = visible ? 1.0 : 0.0
        })
    }
    
}

extension HomeViewController: HomeSplashScreenDelegate {
    func didSelectRetry(in view: HomeSplashScreen) {
        viewModel.refreshData()
    }
}
