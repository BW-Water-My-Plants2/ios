//
//  Plant+Convenience.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/15/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation
import CoreData

extension Plant {
    //Turns CoreData managed plant object into a plantRep for changing to json and sending to server.
    var plantRep: PlantRepresentation? {
        
        guard let nickName = nickName, let notes = notes, let plantClass = plantClass
        else { return nil }
        
        return PlantRepresentation(identifier: identifier, nickName: nickName, plantClass: plantClass, notes: notes, frequency: Int(frequency))
        
    }
    // Creating a new managed object in core data
    @discardableResult convenience init(nickName: String,
                                        frequency: Int16,
                                        identifier: UUID = UUID(),
                                        notes: String,
                                        plantClass: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.nickName = nickName
        self.frequency = Int16(frequency)
        self.identifier = identifier
        self.notes = notes
        self.plantClass = plantClass
    }
    // converting PR coming from JSON into managed object for core data
    @discardableResult convenience init?(plantRep: PlantRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let identifier = plantRep.identifier else { return nil }
        
        self.init(nickName: plantRep.nickName,
                  frequency: Int16(plantRep.frequency ?? 1),
                  identifier: identifier,
                  notes: plantRep.notes,
                  plantClass: plantRep.plantClass,
                  context: context )
    }
}
