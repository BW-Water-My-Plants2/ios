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
        plantClassLabel.text = plants?.plantClass
        plantNicknameTextField.text = plants?.nickName
        plantNicknameTextField.isUserInteractionEnabled = isEditing
        plantTypeTextField.text = plants?.plantClass
        plantTypeTextField.isUserInteractionEnabled = isEditing
        plantNotesTextView.text = plants?.notes
        plantNotesTextView.isUserInteractionEnabled = isEditing
        plantTimerLabel.text = waterTimer?.selectedTimer
    }
    
    // MARK: - IBActions -
    
    @IBAction func addPlantImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let nickname = plantNicknameTextField.text, !nickname.isEmpty,
            let plantType = plantTypeTextField.text, !plantType.isEmpty,
            let plantNotes = plantNotesTextView.text, !plantNotes.isEmpty else { return }
        
        let image = "\(currentImage!)"
        
        let plant = Plant(image: image, nickName: nickname, frequency: 1, notes: plantNotes, plantClass: plantType)
        plantController.addPlant(plant: plant)
        
        do {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.popViewController(animated: true)
        } catch {
            NSLog("Error saving \(error)")
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWaterTimerSegue" {
            guard let timerVC = segue.destination as? WaterTimerViewController else { return }
            timerVC.delegate = self
            timerVC.plant = plants
//            timerVC.popoverPresentationController?.delegate = self
//            timerVC.presentationController?.delegate = self
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
