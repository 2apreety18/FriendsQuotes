//
//  NetworkManager.swift
//  FriendsQuotes
//
//  Created by preety on 30/9/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import Foundation

struct NetworkManager {

    let quoteURL = "https://friends-quotes-api.herokuapp.com/quotes/random"
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data,response,error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(networkData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(networkData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(NetworkData.self, from: networkData)
            print(decodedData.quote)
        } catch {
            print(error)
        }
    }
}
