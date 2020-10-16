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
        
        guard let nickName = nickName, let name = name, let type = type, let notes = notes
        else { return nil }
        
        return PlantRepresentation(identifier: identifier, name: name, nickName: nickName, type: type, notes: notes)
        
    }
    // Creating a new managed object in core data
    @discardableResult convenience init(nickName: String,
                                        name: String,
                                        frequency: Int16,
                                        identifier: UUID = UUID(),
                                        notes: String,
                                        type: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.nickName = nickName
        self.name = name
        self.frequency = Int16(frequency)
        self.identifier = identifier
        self.notes = notes
        self.type = type
    }
    // converting PR coming from JSON into managed object for core data
    @discardableResult convenience init?(plantRep: PlantRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let identifier = plantRep.identifier else { return nil }
        
        self.init(nickName: plantRep.nickName,
                  name: plantRep.name,
                  frequency: Int16(plantRep.frequency ?? 1),
                  identifier: identifier,
                  notes: plantRep.notes,
                  type: plantRep.type,
                  context: context )
    }
}
