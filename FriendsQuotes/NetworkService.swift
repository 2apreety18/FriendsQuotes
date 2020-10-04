//
//  NetworkService.swift
//  FriendsQuotes
//
//  Created by preety on 29/9/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit
import Foundation

class NetworkService {
    
    static let instance = NetworkService()
    private init(){}
    
    let factBaseUrl = "https://friends-quotes-api.herokuapp.com"

    func makeFactRequest(completion: @escaping (String) -> ()){ //completion handler
        
        let randomFactEndpoint = URL(string: factBaseUrl + "/quotes/random")
        guard let url = randomFactEndpoint else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //1st, check to make sure there were no errors
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            //2nd, check that response is of current type & the request was successful
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                debugPrint("Server error")
                return
            }
            
            //3rd, making sure we definitely have data
            guard let data = data else {return}
             //print(data)
            
            //finally, parse JSON data and cast it as a dictionary so we can pull out the fact text to display
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else { return }
                let quote = json["quote"] as? String ?? ""
                _ = json["character"] as? String ?? ""

                
                DispatchQueue.main.async {
                    completion(quote)
                   // completion(character)

                }
                
                
            }catch{
                debugPrint("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
}
