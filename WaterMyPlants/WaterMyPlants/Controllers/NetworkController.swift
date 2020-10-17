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
    
    private func getAllPlants() {
        
    }
}
