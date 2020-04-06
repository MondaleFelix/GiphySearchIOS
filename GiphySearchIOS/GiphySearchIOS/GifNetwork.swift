//
//  GifNetwork.swift
//  GiphySearchIOS
//
//  Created by Mondale on 4/6/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation

class GifNetwork {
    let apiKey = "w9OzCnfFE13FhTbt8N27npUitMV71PSw"

    
    func fetchGifs(searchTerm: String) {
        // Create a GET url request
        let url = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(searchTerm)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            print("Giphy Data: ", data as Any)
        }.resume()
    }
}
