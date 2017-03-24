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

        // Do any additional setup after loading the view.
        guard let unwrappedPersonObject = personObject else{print("unwrappedPersonObject did not unwrap"); return}
        
        self.updateNameLabel.text = unwrappedPersonObject.name
        self.updateCityLabel.text = unwrappedPersonObject.favoriteCity
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changeCityButtonTapped(_ sender: Any) {
        guard let unwrappedPersonObject = personObject else{print("unwrappedPersonObject did not unwrap"); return}
        guard let neededId = unwrappedPersonObject.id else {print("neededId did not unwrap"); return}
    
        
        if (updateCityTextfield.text?.isEmpty)!{
            print("You didn't change the city!")
        }
        else {
            PeopleAPIClient.putPeopleInformation(cityNameVal: self.updateCityTextfield.text!, id: neededId)
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        
        guard let unwrappedPersonObject = personObject else{print("unwrappedPersonObject did not unwrap"); return}
        
        guard let neededId = unwrappedPersonObject.id else{print("neededId did not unwrap"); return}
        
        self.updateNameLabel.text = self.store.peopleArray[neededId-1].name
        
        self.updateCityLabel.text = self.store.peopleArray[neededId-1].favoriteCity
    }

    @IBAction func viewNextButtonTapped(_ sender: Any) {
        guard let unwrappedPersonObject = personObject else{print("unwrappedPersonObject did not unwrap"); return}
        
        guard let neededId = unwrappedPersonObject.id else{print("neededId did not unwrap"); return}
        
        self.updateNameLabel.text = self.store.peopleArray[neededId+1].name
        
        self.updateCityLabel.text = self.store.peopleArray[neededId+1].favoriteCity
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
