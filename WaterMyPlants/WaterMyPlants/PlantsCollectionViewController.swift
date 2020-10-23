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

private let reuseIdentifier = "PlantCell"

class PlantsCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Plant> = {
        let request: NSFetchRequest<Plant> = Plant.fetchRequest()
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "nickName", cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        return frc
    }()

    let loginController = LoginController()
    var user: UserRepresentation?
    var plants = [PlantRepresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK:- Sample Data
        
       
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        return plants.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "PlantDetailSegue",
//                let detailVC = segue.destination as? PlantDetailViewController {
//                    if let indexPath = tableView.indexPathForSelectedRow {
//                        detailVC.animalName = animalNames[indexPath.row]
//                    }
//                    detailVC.loginController = loginController
//                }
          if segue.identifier == "LoginViewModalSegue" {
                // inject dependencies login view controller cannot work without dependency. use bearer token.
                if let loginVC = segue.destination as? LoginViewController {
                    loginVC.loginController = loginController
                }
                else {
                    print("oops")
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
