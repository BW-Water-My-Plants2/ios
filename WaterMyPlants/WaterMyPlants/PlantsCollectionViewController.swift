//
//  PlantsCollectionViewController.swift
//  WaterMyPlants
//
//  Created by Craig Belinfante on 10/13/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class PlantsCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Plant> = {
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nickName", ascending: true)]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "nickName", cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        return frc
    }()

    // MARK: - Properties -
    let loginController = LoginController()
    let plantController = PlantController()
    var user: UserRepresentation?
    var plants = [PlantRepresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // transition to login view if conditions require
        if loginController.bearer == nil {
            performSegue(withIdentifier: "LoginViewModalSegue", sender: self)
        }
    }
    
    func updateViews() {
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.sections?.count ?? 1
        //return plantController.plants.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantCell", for: indexPath) as? PlantCollectionViewCell ?? PlantCollectionViewCell()
      
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlantDetailSegue",
            let detailVC = segue.destination as? PlantsDetailViewController {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                detailVC.plantRep = plantController.plants[indexPath.row]
            }
            detailVC.plantController = plantController
        } else if segue.identifier == "LoginViewModalSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.loginController = loginController
            }
        }
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    
    //    var _fetchedResultsController: NSFetchedResultsController<Plant>? = nil
    //        var blockOperations: [BlockOperation] = []
    //
    //        var fetchedResultController: NSFetchedResultsController<Plant> {
    //            if _fetchedResultsController != nil {
    //                return _fetchedResultsController!
    //            }
    //
    //            let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
    //            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    //
    //            fetchRequest.predicate = NSPredicate(format: "...")
    //
    //            // sort by item text
    //            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "...", ascending: true)]
    //            let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    //
    //            resultsController.delegate = self;
    //            _fetchedResultsController = resultsController
    //
    //            do {
    //                try _fetchedResultsController!.performFetch()
    //            } catch {
    //                let nserror = error as NSError
    //                fatalError("Unresolved error \(nserror)")
    //            }
    //            return _fetchedResultsController!
    //        }
    //
    //        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    //
    //            if type == NSFetchedResultsChangeType.insert {
    //                print("Insert Object: \(newIndexPath)")
    //
    //                if (collectionView?.numberOfSections)! > 0 {
    //
    //                    if collectionView?.numberOfItems( inSection: newIndexPath!.section ) == 0 {
    //                        self.shouldReloadCollectionView = true
    //                    } else {
    //                        blockOperations.append(
    //                            BlockOperation(block: { [weak self] in
    //                                if let this = self {
    //                                    DispatchQueue.main.async {
    //                                        this.collectionView!.insertItems(at: [newIndexPath!])
    //                                    }
    //                                }
    //                                })
    //                        )
    //                    }
    //
    //                } else {
    //                    self.shouldReloadCollectionView = true
    //                }
    //            }
    //            else if type == NSFetchedResultsChangeType.update {
    //                print("Update Object: \(indexPath)")
    //                blockOperations.append(
    //                    BlockOperation(block: { [weak self] in
    //                        if let this = self {
    //                            DispatchQueue.main.async {
    //
    //                                this.collectionView!.reloadItems(at: [indexPath!])
    //                            }
    //                        }
    //                        })
    //                )
    //            }
    //            else if type == NSFetchedResultsChangeType.move {
    //                print("Move Object: \(indexPath)")
    //
    //                blockOperations.append(
    //                    BlockOperation(block: { [weak self] in
    //                        if let this = self {
    //                            DispatchQueue.main.async {
    //                                this.collectionView!.moveItem(at: indexPath!, to: newIndexPath!)
    //                            }
    //                        }
    //                        })
    //                )
    //            }
    //            else if type == NSFetchedResultsChangeType.delete {
    //                print("Delete Object: \(indexPath)")
    //                if collectionView?.numberOfItems( inSection: indexPath!.section ) == 1 {
    //                    self.shouldReloadCollectionView = true
    //                } else {
    //                    blockOperations.append(
    //                        BlockOperation(block: { [weak self] in
    //                            if let this = self {
    //                                DispatchQueue.main.async {
    //                                    this.collectionView!.deleteItems(at: [indexPath!])
    //                                }
    //                            }
    //                            })
    //                    )
    //                }
    //            }
    //        }
    //
    //        public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    //            if type == NSFetchedResultsChangeType.insert {
    //                print("Insert Section: \(sectionIndex)")
    //                blockOperations.append(
    //                    BlockOperation(block: { [weak self] in
    //                        if let this = self {
    //                            DispatchQueue.main.async {
    //                                this.collectionView!.insertSections(NSIndexSet(index: sectionIndex) as IndexSet)
    //                            }
    //                        }
    //                        })
    //                )
    //            }
    //            else if type == NSFetchedResultsChangeType.update {
    //                print("Update Section: \(sectionIndex)")
    //                blockOperations.append(
    //                    BlockOperation(block: { [weak self] in
    //                        if let this = self {
    //                            DispatchQueue.main.async {
    //                                this.collectionView!.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet)
    //                            }
    //                        }
    //                        })
    //                )
    //            }
    //            else if type == NSFetchedResultsChangeType.delete {
    //                print("Delete Section: \(sectionIndex)")
    //                blockOperations.append(
    //                    BlockOperation(block: { [weak self] in
    //                        if let this = self {
    //                            DispatchQueue.main.async {
    //                                this.collectionView!.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet)
    //                            }
    //                        }
    //                        })
    //                )
    //            }
    //        }
    //
    //        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    //
    //            // Checks if we should reload the collection view to fix a bug @ http://openradar.appspot.com/12954582
    //            if (self.shouldReloadCollectionView) {
    //                DispatchQueue.main.async {
    //                    self.collectionView.reloadData();
    //                }
    //            } else {
    //                DispatchQueue.main.async {
    //                    self.collectionView!.performBatchUpdates({ () -> Void in
    //                        for operation: BlockOperation in self.blockOperations {
    //                            operation.start()
    //                        }
    //                        }, completion: { (finished) -> Void in
    //                            self.blockOperations.removeAll(keepingCapacity: false)
    //                    })
    //                }
    //            }
    //        }
    //
    //        deinit {
    //            for operation: BlockOperation in blockOperations {
    //                operation.cancel()
    //            }
    //            blockOperations.removeAll(keepingCapacity: false)
    //        }
}
