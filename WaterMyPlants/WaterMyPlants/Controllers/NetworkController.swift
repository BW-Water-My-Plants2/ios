//
//  NetworkController.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/16/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation

class PlantController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case noData
        case noDecode
        case noToken
        case tryAgain
        case otherError
    }
    
    let fireURL = URL(string: "https://mockplantdata.firebaseio.com/")!
    
    
    private func getAllPlants() {
        //pulls in all data to decode users information
    }
    
    private func addPlant() {
        // adds user plants image, classification, notes, name when user puts done
    }
    
    private func deletePlant() {
        // deletes users plant
    }
}
