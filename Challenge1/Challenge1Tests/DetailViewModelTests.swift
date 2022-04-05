//
//  DetailViewModelTests.swift
//  Challenge1Tests
//
//  Created by Hector Orlando Lopez Orozco on 5/04/22.
//

import XCTest
@testable import Challenge1

class DetailViewModelTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testGetFavorites() throws {
        let vc = DetailViewController()
        let viewModel = DetailViewModel(vc: vc)
        viewModel.getFavorites()
        XCTAssertGreaterThan(viewModel.favorites.count, 0)
    }
}
