//
//  PlantsDetailViewController.swift
//  WaterMyPlants
//
//  Created by Rob Vance on 10/14/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

class PlantsDetailViewController: UIViewController {
    
    // MARK: - IBOutlets -
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var plantClassLabel: UILabel!
    @IBOutlet weak var plantNicknameTextField: UITextField!
    @IBOutlet weak var plantTypeTextField: UITextField!
    @IBOutlet weak var plantNotesTextView: UITextView!
    @IBOutlet weak var plantTimerLabel: UILabel!
    
    // MARK: - Properties -
    var plants: Plant?
    var currentImage: UIImage!
    var plantController = PlantController()
    var wasEdited = false
    var plantRep: PlantRepresentation?
    var waterTimer: WaterTimerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        navigationItem.rightBarButtonItem = editButtonItem
        // Do any additional setup after loading the view.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        if editing { wasEdited = true }
        plantNicknameTextField.isUserInteractionEnabled = editing
        plantTypeTextField.isUserInteractionEnabled = editing
        plantNotesTextView.isUserInteractionEnabled = editing
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if wasEdited {
            guard let nickName = plantNicknameTextField.text, !nickName.isEmpty,
                  let plant = plants else { return }
            
            let notes = plantNotesTextView.text
            let plantClass = plantTypeTextField.text
            plant.nickName = nickName
            plant.notes = notes
            plant.plantClass = plantClass
            
        }
    }
    
    
    func updateViews() {
        guard let plantRep = plantRep else {return}
        
        // plantImage.image = UIImage(systemName: "birds.png")
        plantClassLabel.text = plantRep.plantClass
        plantNicknameTextField.text = plantRep.nickName
        plantNicknameTextField.isUserInteractionEnabled = isEditing
        plantTypeTextField.text = plantRep.plantClass
        plantTypeTextField.isUserInteractionEnabled = isEditing
        plantNotesTextView.text = plantRep.notes
        plantNotesTextView.isUserInteractionEnabled = isEditing
        plantTimerLabel.text = "\(plantRep.frequency ?? 0)"
    }
    
    // MARK: - IBActions -
    
    @IBAction func addPlantImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "UpdateWaterTimer" {
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

extension PlantsDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        plantImage.image = image
        dismiss(animated: true)
        currentImage = image
    }
}
extension PlantsDetailViewController: WaterTimerPickedDelegate {
    func plantTimer(date: Date) {
        
    }    
    
}
