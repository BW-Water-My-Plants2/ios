//
//  PlantsCollectionViewController.swift
//  WaterMyPlants
//
//  Created by Craig Belinfante on 10/13/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PlantsCollectionViewController: UICollectionViewController {

    let loginController = LoginController()
    var user: UserRepresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // guard let user = user else {return}
        
      //  title = "Hi \(user.username)"
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantCell", for: indexPath)
    
       
    
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

}
