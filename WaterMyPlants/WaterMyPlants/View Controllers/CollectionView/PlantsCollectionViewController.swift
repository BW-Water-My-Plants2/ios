//
//  PlantsCollectionViewController.swift
//  WaterMyPlants
//
//  Created by Craig Belinfante on 10/13/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

/*
import UIKit
import CoreData
import Foundation

class PlantsCollectionViewController: UICollectionViewController {
    
    private lazy var plantFRC: [Plant] = {
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nickName", ascending: true)]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "nickName", cacheName: nil)
        frc.delegate = self
        do {
            _ = try context.fetch(fetchRequest)
            let plants = try fetchRequest.execute()
            collectionView.reloadData()
            return plants
        } catch {
            print("\(error)")
        }
        
        return []
    }()
    
    
    // MARK: - Properties -
    let loginController = LoginController()
    let plantController = PlantController()
    var user: UserRepresentation?
    var plants = [PlantRepresentation]()
    var blockOperations: [BlockOperation] = []
    
    deinit {
        for operation: BlockOperation in blockOperations {
            operation.cancel()
        }
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // transition to login view if conditions require
        if loginController.bearer == nil {
            performSegue(withIdentifier: "LoginViewModalSegue", sender: self)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    //    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    //        return plants.count
    //    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plantFRC.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantCell", for: indexPath) as? PlantCollectionViewCell ?? PlantCollectionViewCell()
        
        cell.delegate = self
        cell.plant = plantFRC.object(at: indexPath.item)
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.systemGray.cgColor
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlantDetailSegue",
            let detailVC = segue.destination as? PlantsDetailViewController {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                detailVC.plantRep = plantController.plants[indexPath.item]
            }
            detailVC.plantController = plantController
        } else if segue.identifier == "LoginViewModalSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.loginController = loginController
            }
        }
    }
}


// MARK: Fetched ResultsController

extension PlantsCollectionViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Object")
            
            if (collectionView?.numberOfSections)! > 0 {
                
                if collectionView?.numberOfItems( inSection: newIndexPath!.section ) == 1 {
                    collectionView.reloadData()
                } else {
                    blockOperations.append(
                        BlockOperation(block: { [weak self] in
                            if let this = self {
                                DispatchQueue.main.async {
                                    this.collectionView!.insertItems(at: [newIndexPath!])
                                }
                            }
                        })
                    )
                }
                
            } else {
                collectionView.reloadData()
            }
        }
        else if type == NSFetchedResultsChangeType.update {
            print("Update Object")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            
                            this.collectionView!.reloadItems(at: [indexPath!])
                        }
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.move {
            print("Move Object")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            this.collectionView!.moveItem(at: indexPath!, to: newIndexPath!)
                        }
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.delete {
            print("Delete Object")
            if collectionView?.numberOfItems(inSection: indexPath!.section) == 1 {
                collectionView.reloadData()
            } else {
                blockOperations.append(
                    BlockOperation(block: { [weak self] in
                        if let this = self {
                            DispatchQueue.main.async {
                                this.collectionView!.deleteItems(at: [indexPath!])
                            }
                        }
                    })
                )
            }
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            this.collectionView!.insertSections(NSIndexSet(index: sectionIndex) as IndexSet)
                        }
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.update {
            print("Update Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            this.collectionView!.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet)
                        }
                    }
                })
            )
        }
        else if type == NSFetchedResultsChangeType.delete {
            print("Delete Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        DispatchQueue.main.async {
                            this.collectionView!.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet)
                        }
                    }
                })
            )
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({ self.collectionView.map {self.performCollectionViewChange(change: $0)} }, completion: nil)
    }
    
    func performCollectionViewChange(change: UICollectionView) {
    }
    
}

extension PlantsCollectionViewController: PlantCellDelegate {
    func didUpdatePlant(plant: Plant) {
        plantController.addPlant(plant: plant)
        collectionView.reloadData()
    }
}
*/
