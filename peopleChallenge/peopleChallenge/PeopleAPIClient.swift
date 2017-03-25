//
//  PeopleAPIClient.swift
//  peopleChallenge
//
//  Created by Flatiron School on 3/23/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class PeopleAPIClient{

    class func getPeopleInformation (completion:@escaping(Array<Any>)->()){
        
        var jsonPeopleResponse : Array<Any> = []
        
        let getPeopleUrl = UrlInformation.neededUrl
        
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

    class func postPeopleInformation(nameVal: String, favoriteCityVal: String) -> (){
        
        let dictionaryParameters = ["name": nameVal,
                                    "favoriteCity": favoriteCityVal,
                                    "id": ""] as [String : Any]
        
        let postingUrl = UrlInformation.neededUrl
        
        let convertingPostingUrl = URL(string: postingUrl)
        
        guard let unwrappedConvertedPostingUrl = convertingPostingUrl else{print("convertingPostingUrl did not unwrap"); return}
        
        var request = URLRequest(url: unwrappedConvertedPostingUrl)
        
        request.httpMethod = "POST"
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: dictionaryParameters,options: .prettyPrinted)
        }
        catch let error{
            print(error)
        }
        
        let requestString = NSString(data: request.httpBody!, encoding: String.Encoding.ascii.rawValue)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let unwrappedData = data else{print("data did not unwrap"); return}
            
            guard let httpResponse = response as? HTTPURLResponse else{print("httpResponse did not unwrap"); return}
            
            if httpResponse.statusCode == 200{
                print("parameterdictionary was posted to the server")
            }
                
            else if httpResponse.statusCode != 200{
                print("parameterDictionary was not posted to the server")
            }
        }
        task.resume()
    }

    class func getParticularPersonInformation (id: Int, completion:@escaping([String:Any])->()){
        
        var jsonPersonResponse : [String:Any] = [:]
        
        let getPeopleUrl = "\(UrlInformation.neededUrl)/\(id)"
        
        let convertedGetPeopleUrl = URL(string: getPeopleUrl)
        
        guard let unwrappedConvertedGetPeopleUrl = convertedGetPeopleUrl else{
            print("converetedGetBookUrl did not unwrap"); return}
        
        let request = URLRequest(url: unwrappedConvertedGetPeopleUrl)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let unwrappedJsonData = data else{ print("data from Json did not unwrap"); return}
            
            guard let httpResponse = response as? HTTPURLResponse else{print("httpResponse did not unwrap"); return}
            
            if httpResponse.statusCode == 200 {
                
                let jsonResponseArray = try? JSONSerialization.jsonObject(with: unwrappedJsonData, options: []) as! [String:Any]
                
                guard let unwrappedJsonResponse = jsonResponseArray else{print("jsonResponse did not unwarp"); return}
                
                jsonPersonResponse = unwrappedJsonResponse
                
                completion(jsonPersonResponse)
            }
                
            else if httpResponse.statusCode != 200{
                print("You did not get an JSON back from the network call")
            }
        })
        task.resume()
    }

    class func putPeopleInformation (cityNameVal: String, id: Int) -> (){
        
        let appendedDictionary: [String: Any] = ["favoriteCity": cityNameVal]
        
        let url = "\(UrlInformation.neededUrl)/\(id)"
        
        let convertedUrl = URL(string: url)
        
        guard let unwrappedConvertedUrl = convertedUrl else {print("convertedUrl did not unwrap"); return}
        
        var request = URLRequest(url: unwrappedConvertedUrl)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "PUT"
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: appendedDictionary,options: [])
        }
        catch let error{
            print(error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let unwrappedData = data else{print("data did not unwrap"); return}
            
            guard let httpResponse = response as? HTTPURLResponse else{print("httpResponse did not unwrap"); return}
            
            if httpResponse.statusCode == 200 {
                print("You have PUT to the server")
            }
                
            else if httpResponse.statusCode != 200 {
                print("You have not PUT to the server")
            }
        }
        task.resume()
    }
    
    class func deleteIndividualPerson(id: Int) -> (){
        
        let url = "\(UrlInformation.neededUrl)/\(id)"
        
        let convertedUrl = URL(string: url)
        
        guard let unwrappedConvertedUrl = convertedUrl else {print("unwrappedConvertedUrl did not unwrap"); return}
        
        var request = URLRequest(url: unwrappedConvertedUrl)
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else{print("httpResponse did not unwrap"); return}
            
            if httpResponse.statusCode == 200 {
                print("You successfully deleted a Person!")
            }
            else if httpResponse.statusCode != 200{
                print("You have not deleted a Person!")
            }
        }
        task.resume()
    }
}
