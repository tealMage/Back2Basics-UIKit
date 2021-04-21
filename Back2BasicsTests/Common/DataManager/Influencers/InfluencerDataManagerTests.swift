//
//  InfluencerDataManagerTests.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/21/21.
//

import XCTest
import RxSwift
@testable import Back2Basics

class InfluencerDataManagerTests: XCTestCase {
    private var serverClient: MockServerClient!
    private var dataManager: InfluencerDataManager!
    private var disposeBag: DisposeBag!
    private var locationManagerInterface: MockLocationManagerInterface!

    override func setUp() {
        super.setUp()

        disposeBag = DisposeBag()
        serverClient = MockServerClient()
        locationManagerInterface = MockLocationManagerInterface()
        
        dataManager = InfluencerDataManager(serverClient: serverClient, locationManagerInterface: locationManagerInterface)

    }

    override func tearDown() {
        serverClient = nil
        dataManager = nil
        disposeBag  = nil
        
        super.tearDown()
    }

    func testFetchNearbyInfluencers() {
        let exp = expectation(description: "fetchNearbyInfluencers should fetch the nearby influencers data")
        let location = TestHelpers.mockLocation()
        locationManagerInterface.deviceLocation = location
        serverClient.expectedResponse = InfluencerHelper.influencersFromInfluencerJSON()
        
        dataManager.fetchNearbyInfluencers()
            .subscribe(onSuccess: { influencers in
                XCTAssertEqual(self.serverClient.calledService as? InfluencerService, InfluencerService.fetchNearbyInfluencers(location))

                InfluencerHelper.verifyInfluencers(influencers)
                exp.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchNearbyInfluencersNoLocation() {
        let exp = expectation(description: "fetchNearbyInfluencers should fetch the influencers data")
        serverClient.expectedResponse = InfluencerHelper.influencersFromInfluencerJSON()
        
        dataManager.fetchNearbyInfluencers()
            .subscribe(onSuccess: { influencers in
                XCTAssertEqual(self.serverClient.calledService as? InfluencerService, InfluencerService.fetchFeaturedInfluencers)

                InfluencerHelper.verifyInfluencers(influencers)
                exp.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

}
