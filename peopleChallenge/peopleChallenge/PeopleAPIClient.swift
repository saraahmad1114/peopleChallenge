//
//  PeopleAPIClient.swift
//  peopleChallenge
//
//  Created by Flatiron School on 3/23/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class PeopleAPIClient{

    class func getBookInformation (completion:@escaping(Array<Any>)->()){
        var jsonPeopleResponse : Array<Any> = []
        
        let getPeopleUrl = "https://peopleproject.herokuapp.com/people"
        
        let convertedGetPeopleUrl = URL(string: getPeopleUrl)
        
        guard let unwrappedConvertedGetPeopleUrl = convertedGetPeopleUrl else{
            print("converetedGetBookUrl did not unwrap"); return}
        
        let request = URLRequest(url: unwrappedConvertedGetPeopleUrl)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let unwrappedJsonData = data else{ print("data from Json did not unwrap"); return}
            
            guard let httpResponse = response as? HTTPURLResponse else{print("httpResponse did not unwrap"); return}
            
            if httpResponse.statusCode == 200 {
                
                let jsonResponseArray = try? JSONSerialization.jsonObject(with: unwrappedJsonData, options: []) as! Array<Any>
                
                guard let unwrappedJsonResponse = jsonResponseArray else{print("jsonResponse did not unwarp"); return}
                
                jsonPeopleResponse = unwrappedJsonResponse
                
                completion(jsonPeopleResponse)
            }
                
            else if httpResponse.statusCode != 200{
                print("You did not get an JSON back from the network call")
            }
        })
        task.resume()
    }






}
