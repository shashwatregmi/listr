//
//  TaskCollectionViewController.swift
//  listr
//
//  Created by Regmi on 2020-05-06.
//  Copyright © 2020 Regmi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TaskCollectionViewController: UICollectionViewController {

    //Properties
     
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleTasks()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
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
    
    //private
    
    private func loadSampleTasks() {
        let photo1 = UIImage(named: "task1")
        let photo2 = UIImage(named: "task2")
        let photo3 = UIImage(named: "task3")
        
        guard let task1 = Task(name: "Grocery Shopping", img: photo1, priority: 4) else {
            fatalError("Unable to instantiate task1")
        }
         
        guard let task2 = Task(name: "Wash the car", img: photo2, priority: 2) else {
            fatalError("Unable to instantiate task2")
        }
         
        guard let task3 = Task(name: "Take the dog for a walk", img: photo3, priority: 5) else {
            fatalError("Unable to instantiate task3")
        }
        
        tasks += [task1, task2, task3]

    }

}
