//
//  ApiService.swift
//  youtube
//
//  Created by PhongLe on 4/3/17.
//  Copyright © 2017 PhongLe. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchHomeFeed(completion: @escaping (([Video]) -> ())) {
        let urlString = "\(baseUrl)/home_num_likes.json"
        fetchFeedForUrlString(urlString: urlString, completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping (([Video]) -> ())) {
        let urlString = "\(baseUrl)/trending.json"
        fetchFeedForUrlString(urlString: urlString, completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping (([Video]) -> ())) {
        let urlString = "\(baseUrl)/subscriptions.json"
        fetchFeedForUrlString(urlString: urlString, completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let urlString = URL(string: urlString)
        if let url = urlString {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let data = data {
                    do {
                        if let jsonDictionaries : [[String : AnyObject]] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String : AnyObject]] {
                            
                            DispatchQueue.main.async {
                               completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                            }
                        }
                    } catch let jsonError{
                        print(jsonError)
                    }
                }
            }).resume()
        }
    }
    
}
