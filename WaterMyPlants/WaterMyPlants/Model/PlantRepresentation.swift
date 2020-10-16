//
//  PlantRepresentation.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/15/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation

struct PlantRepresentation: Codable {
    var identifier: UUID?
    var name: String
    var nickName: String
    var type: String
    var frequency: Int16
}
