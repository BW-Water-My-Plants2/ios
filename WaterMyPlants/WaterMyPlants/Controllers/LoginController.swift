//
//  networkController.swift
//  WaterMyPlants
//
//  Created by Craig Belinfante on 10/15/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation
import UIKit

final class LoginController {
    
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
    
    var bearer: Bearer?
    
    private let signUpURL = URL(string: "https://lambdaanimalspotter.herokuapp.com/api/users/signup")!
    private let signInURL = URL(string: "https://lambdaanimalspotter.herokuapp.com/api/users/login")!
    
    private func postRequest(for url: URL) -> URLRequest {
         var request = URLRequest(url: url)
         request.httpMethod = HTTPMethod.post.rawValue
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         return request
     }
    
    func signUp(with user: UserRepresentation, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
          print("signUpUrl = \(signUpURL.absoluteString)")
          
          var request = postRequest(for: signUpURL)
          
          do {
            
              let jsonData = try JSONEncoder().encode(user)
              print(String(data:jsonData, encoding: .utf8)!)
              request.httpBody = jsonData
              
              let task = URLSession.shared.dataTask(with: request) {  (data, response, error) in
                  if let error = error {
                      print("Sign up failed with error: \(error)")
                      completion(.failure(.noData))
                      return
                  }
                  
                  guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                        print("this is our error")
                          completion(.failure(.noData))
                          return
                  }
                guard let data = data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    
                }
                  completion(.success(true))
                  
              }
              task.resume()
          } catch {
              print("Error encoding user: \(error)")
              completion(.failure(.noData))
          }
      }
    
    func signIn(with user: UserRepresentation, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
           var request = postRequest(for: signInURL)
           
           do {
               let jsonData = try JSONEncoder().encode(user)
               request.httpBody = jsonData
               
               let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                   if let error = error {
                       print("Sign in failed with error: \(error)")
                       completion(.failure(.noData))
                       return
                   }
                   guard let response = response as? HTTPURLResponse,
                       response.statusCode == 200 else {
                    print("response code not working")
                           completion(.failure(.noData))
                           return
                   }
                   
                   guard let data = data else {
                       completion(.failure(.noData))
                       return
                   }
                   
                   do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                       self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
                       completion(.success(true))

                   } catch {
                       print("Error decoding bearer: \(error)")
                       completion(.failure(.noToken))
                   }
               }
               task.resume()
           } catch {
               print("Error encoding user: \(error.localizedDescription)")
               completion(.failure(.otherError))
           }
           
       }
}
