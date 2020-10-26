//
//  PlantCollectionViewCell.swift
//  WaterMyPlants
//
//  Created by Craig Belinfante on 10/22/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

/*
protocol PlantCellDelegate: class {
    func didUpdatePlant(plant: Plant)
}

class PlantCollectionViewCell: UICollectionViewCell {
    
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: PlantCellDelegate?
    
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var waterDropTimer: UIButton!
    
    private func updateViews() {
        guard let plant = plant else {return}
        
        plantNameLabel.text = plant.nickName
        
        do {
            try CoreDataStack.shared.mainContext.save()
            delegate?.didUpdatePlant(plant: plant)
        } catch {
            NSLog("Error saving \(error)")
        }
        
    }
}
*/
