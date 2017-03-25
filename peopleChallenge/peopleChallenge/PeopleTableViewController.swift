//
//  PeopleTableViewController.swift
//  peopleChallenge
//
//  Created by Flatiron School on 3/23/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    let store = PeopleDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        self.store.getPeopleInformation { (peopleArray) in
            print("*********************")
            print(peopleArray)
            print("*********************")
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.store.peopleArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)

        // Configure the cell...
        if let personName = self.store.peopleArray[indexPath.row].name{
            cell.textLabel?.text = personName
        }
        if let personFavoriteCity = self.store.peopleArray[indexPath.row].favoriteCity{
            cell.detailTextLabel?.text = personFavoriteCity
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let personToBeDeleted = self.store.peopleArray[indexPath.row]
            
            guard let needId = personToBeDeleted.id else{
                print("needId did not unwrap"); return
            }
            PeopleAPIClient.deleteIndividualPerson(id: needId)

            self.store.peopleArray.remove(at: indexPath.row)

            self.tableView.reloadData()
            
        }
    }
    
    //Segue function, to pass on information to other view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayPerson"{
            if let destinationVC = segue.destination as? PersonViewController {
                
                let neededIndexPath = self.tableView.indexPathForSelectedRow!
                
                destinationVC.personObject = self.store.peopleArray[neededIndexPath.row]
                print("This worked!")
            }
            
        }
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
