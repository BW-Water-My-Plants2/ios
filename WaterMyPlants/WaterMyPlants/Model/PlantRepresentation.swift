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
    //add image to core data
    var imageName = ""
    var nickName: String
    var plantClass: String
    var notes: String
    var frequency: Int?
}
