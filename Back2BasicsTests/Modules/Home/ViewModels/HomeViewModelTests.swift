//
//  HomeViewModelTests.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/21/21.
//

import XCTest
import RxSwift
import RxTest
import RxCocoa

@testable import Back2Basics

class HomeViewModelTests: XCTestCase {

    private var dataManager: InfluencerDataManager!
    private var coordinator: MockHomeCoordinator!
    private var serverClient: MockServerClient!

    private var viewModel: HomeViewModel!
    private var locationManagerInterface: MockLocationManagerInterface!
    
    private var disposeBag: DisposeBag!


    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        
        coordinator = MockHomeCoordinator()
        
        serverClient = MockServerClient()
        locationManagerInterface = MockLocationManagerInterface()
        
        dataManager = InfluencerDataManager(serverClient: serverClient, locationManagerInterface: locationManagerInterface)
        
        viewModel = HomeViewModel(homeCoordinator: coordinator, influencerDataInterface: dataManager, locationManagerInterface: locationManagerInterface)
    }
    
    override func tearDown() {
        coordinator = nil
        dataManager = nil
        
        locationManagerInterface = nil
        disposeBag = nil
        viewModel = nil
        
        super.tearDown()
    }

}

extension HomeViewModelTests {
    func testShowSelectedInfluencer() {
        let influencers = InfluencerHelper.influencersFromInfluencerJSON()
        guard let influencer = influencers.first else {
            XCTFail("No influencers in call")
            return
        }
        
        viewModel.didSelectInfluencer(influencer, viewController: UIViewController())

        XCTAssertTrue(coordinator.didCallShowInfluencer)
    }
    
}
