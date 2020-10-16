//
//  PlantsDetailViewController.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/14/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

class PlantsDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
