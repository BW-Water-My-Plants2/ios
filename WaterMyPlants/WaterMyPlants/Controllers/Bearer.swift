//
//  Bearer.swift
//  WaterMyPlants
//
//  Created by Craig Belinfante on 10/15/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation

struct Bearer: Codable {
    var token: String
    var id: Int
    var userId: Int
}
