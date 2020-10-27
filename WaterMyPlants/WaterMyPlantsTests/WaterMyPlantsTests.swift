//
//  WaterMyPlantsTests.swift
//  WaterMyPlantsTests
//
//  Created by Craig Belinfante on 10/13/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import XCTest
@testable import WaterMyPlants

class WaterMyPlantsTests: XCTestCase {

    var plantController = PlantController()
    
    override func setUpWithError() throws {
    }

    func testExample() throws {
       
    }
    
    func testFetchingPlantData() throws {
       let expectation = XCTestExpectation(description: "GetPlant")
        plantController.getAllPlants {_ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        XCTAssertGreaterThan(plantController.plants.count, 0)
    }
    
//    func testCreatingNewPlant() throws {
//           let expectation = XCTestExpectation(description: "NewPlant")
//           plantController.addPlant(plant: Plant) {
//               expectation.fulfill()
//           }
//           wait(for: [expectation], timeout: 3)
//
//           XCTAssertEqual(plantController.plants.last!.title, "PlantTest")
//       }

}
