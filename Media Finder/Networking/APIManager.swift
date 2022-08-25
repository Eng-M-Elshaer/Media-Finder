//
//  APIManager.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 5/7/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Alamofire

class APIManager {
    
    //MARK:- Get Data From API
    class func getDataFromAPI(term: String, media: String, completion: @escaping (_ error: Error?, _ mediaArray: [Media]?) -> Void) {
        
        let params = [ParameterKey.term: term, ParameterKey.media: media]
        
        Alamofire.request(Urls.base, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: nil).response { response in
            
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            guard let data = response.data else {
                print("Didn't Get Any Data From The API")
                return
            }
            do {
                let decoder = JSONDecoder()
                let mediaArr = try decoder.decode(MediaResponse.self, from: data).results
                completion(nil, mediaArr)
            } catch let error {
                completion(error, nil)
            }
        }
    }
}
