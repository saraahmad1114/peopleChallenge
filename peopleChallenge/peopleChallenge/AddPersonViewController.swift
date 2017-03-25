//
//  AddPersonViewController.swift
//  peopleChallenge
//
//  Created by Flatiron School on 3/24/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController {

    
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var favoriteCityTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addPersonButtonTapped(_ sender: Any) {
        
        let firstCondition = self.nameTextfield.text?.isEmpty
        
        let secondCondition = self.favoriteCityTextfield.text?.isEmpty
        
        if firstCondition! && secondCondition! {
            
            let alert = UIAlertController(title: "FORM MISSING INFORMATION", message: "You have not filled out the name and the favorite city", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
            
        else {
            
            guard let personName = self.nameTextfield.text else{
                print("personName did not unwrap"); return}
            
            guard let personFavoriteCity = self.favoriteCityTextfield.text else{
                print("personFavoriteCity did not unwrap"); return}
            
            PeopleAPIClient.postPeopleInformation(nameVal: personName, favoriteCityVal: personFavoriteCity)
           
        }
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }


}
