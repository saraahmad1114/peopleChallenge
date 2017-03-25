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

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.store.peopleArray.removeAll()
        
        self.store.getPeopleInformation { (peopleArray) in
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.peopleArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)

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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayPerson"{
            if let destinationVC = segue.destination as? PersonViewController {
                
                let neededIndexPath = self.tableView.indexPathForSelectedRow!
                
                destinationVC.personObject = self.store.peopleArray[neededIndexPath.row]
                print("This worked!")
            }
            
        }
        
    }


}
