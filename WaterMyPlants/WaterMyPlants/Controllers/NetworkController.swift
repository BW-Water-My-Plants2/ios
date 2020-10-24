//
//  NetworkController.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/16/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation

class PlantController {
    
    typealias CompletionHandler = ((Result<Bool, NetworkError>) -> Void)
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case noData
        case noEncode
        case noDecode
        case noToken
        case tryAgain
        case otherError
    }
    
    var plants = [PlantRepresentation]()
    
    let fireURL = URL(string: "https://mockplantdata.firebaseio.com/")!
    let baseURL = URL(string: "https://water-myplants.herokuapp.com/api/plants/:id")!
    let addPlantURL = URL(string: "https://water-myplants.herokuapp.com/api/plants")!
    
    init() {
        getAllPlants()
    }
    
    func getAllPlants(completion: @escaping CompletionHandler = { _ in }) {
      //  guard let _ = Plant.identifier else { fatalError() }
        
        let requestURL = fireURL.appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let plantsArray = Array(try JSONDecoder().decode([String: PlantRepresentation].self, from: data).values)
                self.plants = plantsArray
                try self.updatePlant(with: plantsArray)
                completion(.success(true))
            } catch {
                print("Error decoding plants data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
        }
        task.resume()
    }
    
    private func updatePlant(with: [PlantRepresentation]) throws {
       
        

    }
    
    func addPlant(plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = plant.identifier else {
            completion(.failure(.tryAgain))
            return
        }
        
        let requestURL = fireURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        do {
            guard let representation = plant.plantRep else {
                completion(.failure(.noData))
                return
            }
            
            request.httpBody = try JSONEncoder().encode(representation)
        } catch {
            print("Error encoding task \(plant): \(error)")
            completion(.failure(.noEncode))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }
        task.resume()
    }
    func deletePlant(_ plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = plant.identifier else {
            completion(.failure(.tryAgain))
            return
        }
        
        let requestURL = fireURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            print(response!)
            completion(.success(true))
        }
        task.resume()
    }
}


//https://water-myplants.herokuapp.com/api/auth/register
//https://water-myplants.herokuapp.com/api/auth/login
//https://water-myplants.herokuapp.com/api/plants
//DELETE PLANT: https://water-myplants.herokuapp.com/api/plants/:id
//FIND PLANT BY ID: https://water-myplants.herokuapp.com/api/plants/:id
//ADD PLANT: https://water-myplants.herokuapp.com/api/plants
//UPDATE PLANT: https://water-myplants.herokuapp.com/api/plants/:id
