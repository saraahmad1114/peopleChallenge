//
//  PeopleDataStore.swift
//  peopleChallenge
//
//  Created by Flatiron School on 3/23/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class PeopleDataStore{

    static let sharedInstance = PeopleDataStore()
    private init(){}
    
    var peopleArray : [People] = []
    
    func addPerson(person: People){
      // so objective c like. lol. I prefere objective c
        self.peopleArray.append(person)
    }
    
    func getPeopleInformation(completion:@escaping([People]) ->()){
    
        PeopleAPIClient.getPeopleInformation { (peopleArray) in
            
            for singleDictionary in peopleArray{
            
                guard let unwrappedSingleDictionary = singleDictionary as? [String: Any] else{print("unwrappedSingleDicitonary did not unwrap"); return}
                
                guard let unwrappedPersonName = unwrappedSingleDictionary["name"] as? String else{print("unwrappedPersonName did not unwrap"); return}
                
                guard let unwrappedPersonFavoriteCity = unwrappedSingleDictionary["favoriteCity"] as? String else{print("unwrappedPersonFavoriteCity did not unwrap"); return}
                
                guard let unwrappedPersonId = unwrappedSingleDictionary["id"] as? Int else{print("unwrappedPersonId did not unwrap"); return}
                
                let singlePersonObject = People.init(name: unwrappedPersonName, favoriteCity: unwrappedPersonFavoriteCity, id: unwrappedPersonId)
                
                self.peopleArray.append(singlePersonObject)
                
                print("****************PERSON INFORMATION**************")
                print("PERSON NAME: \(singlePersonObject.name)")
                print("PERSON FAVORITE CITY: \(singlePersonObject.favoriteCity)")
                print("PERSON ID: \(singlePersonObject.id)")
                print("************************************************")
            }
            completion(self.peopleArray)
         
        }
    
    }






}
