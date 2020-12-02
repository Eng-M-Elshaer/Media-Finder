//
//  APIManager.swift
//  NetworkingDemo
//
//  Created by IDEAcademy on 3/17/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit
import Alamofire

class APIManager {
    
    class func getDataFromAPI(term:String, media:String, completion: @escaping (_ error: Error?, _ movies: [Media]?) -> Void) {
        
        let params = [ ParameterKey.term : term , ParameterKey.media : media ]
        
        Alamofire.request(Urls.base, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: nil).response { response in
                    guard response.error == nil else {
                        print(response.error!)
                        completion(response.error, nil)
                        return
                    }

                    guard let data = response.data else {
                        print("didn't get any data from API")
                        return
                    }
             
                do {
                    let decoder = JSONDecoder()
                    let mediaArr = try decoder.decode(MediaResponse.self, from: data).results
                    completion(nil, mediaArr)
                } catch let error {
                    print(error)
                }
        }
    }
}
