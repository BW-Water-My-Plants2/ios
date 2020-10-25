//
//  PlantCollectionViewCell.swift
//  WaterMyPlants
//
//  Created by Craig Belinfante on 10/22/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

class PlantCollectionViewCell: UICollectionViewCell {
    
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var waterDropTimer: UIButton!
    
    private func updateViews() {
           guard let plant = plant else {return}
           
        plantNameLabel.text = plant.nickName
       // plantImage.image = UIImage(systemName: "birds.png")
        
       }
}
