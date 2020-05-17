//
//  TaskTableViewController.swift
//  listr
//
//  Created by Regmi on 2020-05-07.
//  Copyright © 2020 Regmi. All rights reserved.
//

import UIKit
import os.log


class TaskTableViewController: UITableViewController {
    
    var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        loadSampleTasks()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TaskTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell  else {
                fatalError("The dequeued cell is not an instance of TaskTableViewCell.")
            }
        let task = tasks[indexPath.row]
        cell.nameLabel.text = task.name
        cell.imgView.image = task.img
        cell.priorityControl.priority = task.priority
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tasks.remove(at: indexPath.row)
            saveTasks()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let rowToMove = tasks[fromIndexPath.row]
        tasks.remove(at: fromIndexPath.row)
        tasks.insert(rowToMove, at: to.row)
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "AddTask":
                os_log("Adding a new task.", log: OSLog.default, type: .debug)
            
            case "ShowDetail":
                guard let taskDetailViewController = segue.destination as? TaskViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
             
                guard let selectedTaskCell = sender as? TaskTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
             
                guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
             
                let selectedTask = tasks[indexPath.row]
                taskDetailViewController.task = selectedTask
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? TaskViewController, let task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new task.
                let newIndexPath = IndexPath(row: tasks.count, section: 0)
                tasks.append(task)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveTasks()
        }
    }

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
    
    private func saveTasks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path)
    }
    
    private func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Task.ArchiveURL.path) as? [Task]
    }
    
}

