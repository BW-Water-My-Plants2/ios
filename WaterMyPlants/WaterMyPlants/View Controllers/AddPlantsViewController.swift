//
//  AddPlantsViewController.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/14/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

class AddPlantsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateViews() {
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWaterTimerSegue" {
            guard let timerVC = segue.destination as? WaterTimerViewController else { return }
            timerVC.popoverPresentationController?.delegate = self
            timerVC.presentationController?.delegate = self
        }
    }
}

extension AddPlantsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
extension AddPlantsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        updateViews()
    }
}

