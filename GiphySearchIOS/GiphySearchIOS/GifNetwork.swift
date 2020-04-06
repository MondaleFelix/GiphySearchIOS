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

    
        func fetchGifs(searchTerm: String, completion: @escaping (_ response: GifArray?) -> Void) {

            let url = urlBuilder(searchTerm: searchTerm)
            // Meat!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let e = error {
                    print("Error fetching from Giphy: ", e.localizedDescription)
                }
                do {
                    // Decode the data into array of Gifs
                    DispatchQueue.main.async {
                        let object = try! JSONDecoder().decode(GifArray.self, from: data!)
                        completion(object)
                    }
                }
                print("Giphy Data: ", data as Any)
            }.resume()
        }
        
        func urlBuilder(searchTerm: String) -> URL {
            let apikey = apiKey
            var components = URLComponents()
            
            components.scheme = "https"
            components.host = "api.giphy.com"
            components.path = "/v1/gifs/search"
            components.queryItems = [
                URLQueryItem(name: "api_key", value: apikey),
                URLQueryItem(name: "q", value: searchTerm),
                URLQueryItem(name: "limit", value: "5") // Edit limit to display more gifs
            ]
            return components.url!
        }
}
