//
//  WaterTimerViewController.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/14/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

class WaterTimerViewController: UIViewController {

    // MARK: - IBOutlets -
    @IBOutlet weak var waterFrequency: UIPickerView!
    
    // MARK: - Properties -
    var plant: Plant?
    var selectedTimer: String?
    private let timers = ["Daily", "Every other day", "Weekly", "Demo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waterFrequency.dataSource = self
        waterFrequency.delegate = self
    }
    
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    
    @objc func dismissKeyboard() {
    }
    

}
extension WaterTimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTimer = timers[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timers[row]
    }
    
    
}
