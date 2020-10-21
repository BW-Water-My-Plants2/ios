//
//  PlantsDetailViewController.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/14/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

class PlantsDetailViewController: UIViewController {

    //MARK: - IBOutlets -
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var plantClassLabel: UILabel!
    @IBOutlet weak var plantNicknameTextField: UITextField!
    @IBOutlet weak var plantTypeTextField: UITextField!
    @IBOutlet weak var plantNotesTextView: UITextView!
    
    
    //MARK: - Properties -
    var plant: Plant?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
       }
    
    //MARK: - IBActions -
    
    @IBAction func addPlantImage(_ sender: Any) {
        
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWaterTimerSegue" {
            guard let timerVC = segue.destination as? WaterTimerViewController else { return }
            timerVC.popoverPresentationController?.delegate = self
            timerVC.presentationController?.delegate = self
        }
    }
}

extension PlantsDetailViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
extension PlantsDetailViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        updateViews()
    }
}
