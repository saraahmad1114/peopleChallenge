//
//  PersonViewController.swift
//  peopleChallenge
//
//  Created by Flatiron School on 3/24/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    
    let store = PeopleDataStore.sharedInstance
    
    var personObject: People?

    @IBOutlet weak var updateNameLabel: UILabel!
    
    @IBOutlet weak var updateCityLabel: UILabel!
    
    @IBOutlet weak var updateCityTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let unwrappedPersonObject = personObject else{print("unwrappedPersonObject did not unwrap"); return}
        
        self.updateNameLabel.text = unwrappedPersonObject.name
        self.updateCityLabel.text = unwrappedPersonObject.favoriteCity
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func changeCityButtonTapped(_ sender: Any) {
        guard let unwrappedPersonObject = personObject else{print("unwrappedPersonObject did not unwrap"); return }
        guard let neededId = unwrappedPersonObject.id else {print("neededId did not unwrap"); return }
        guard let neededCity = self.updateCityTextfield.text else{print("neededCity did not unwrap"); return }
    
        if (updateCityTextfield.text?.isEmpty)!{
            print("You didn't change the city!")
        }
        else {
            PeopleAPIClient.putPeopleInformation(cityNameVal: neededCity, id: neededId)
            
        }
    }
 

}
