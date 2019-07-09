//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by UAG on 2019/7/8.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    //MARK: action
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){

        if let sourceViewController = sender.source as?
            MealViewController,let meal = sourceViewController.meal{
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //edit existing rows
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
            // add a new meal
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    //MARK: properties
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // use the edit button item provied by table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        // load the sample data
        loadSampleMeals()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cell are reused and should be dequeue using a cell indentifier
        let cellIndentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("The dequeue cell is not instance of MealTableViewCell")
        }

        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Add a new meal", log: OSLog.default, type:.debug)
        case "ShowDetial":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination \(segue.destination)")
            }
            guard let selectMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected destination \(sender ?? "kk")")
            }
            guard let indexPath = tableView.indexPath(for: selectMealCell) else {
                fatalError("The selected cell is not displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            fatalError("Unexpected segue inditifier; \(segue.identifier ?? "kk")")
        }
    }


    //MARK: private method
    private func loadSampleMeals(){
        let photo1 = UIImage(named: "p1");
        let photo2 = UIImage(named: "p2");
        let photo3 = UIImage(named: "p3");
        guard let meal1 = Meal.init(name: "meal1", photo: photo1, rating: 2) else {
            fatalError("unable to initialize meal1")
        }
        
        guard let meal2 =  Meal.init(name: "meal2", photo: photo2, rating: 3) else {
            fatalError("unable to initialize meal2")
        }
        
        guard let meal3 =  Meal.init(name: "meal3", photo: photo3, rating: 5) else {
            fatalError("unable to initialize meal3")
        }
        meals += [meal1, meal2, meal3]
    }
}
