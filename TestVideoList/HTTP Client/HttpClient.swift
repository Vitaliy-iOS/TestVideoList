//
//  HttpClient.swift
//  TestVideoList
//
//  Created by Vitaliy on 10.04.2020.
//  Copyright © 2020 KorefeyGroup. All rights reserved.
//

import UIKit
import Alamofire

class HttpClient: NSObject {
    
    static let shared = HttpClient()
//    var washList: Array<CarWashBase> = []

    let api_key = "ZSl1tezcETAoirOoEOkCeA2JddgcXOX7"
    let hostLink = "https://api.giphy.com/v1/gifs/"
    let search = "search?"

    func getSearchGifs(searchString: String, completion: @escaping (_ result: VideoListArray)->()) {

        let parameters: [String: AnyObject] = [
            "api_key": api_key as AnyObject,
            "q": searchString as AnyObject,
            "limit": 20 as AnyObject,
            "offset": 0 as AnyObject,
            "rating": "G" as AnyObject,
            "lang": "en" as AnyObject
        ]
        
        let requestSearchList = hostLink + search
        AF.request(requestSearchList, method: .get, parameters: parameters).responseJSON { responseJSON in
            switch responseJSON.result {
                case .success(let value):
                    let resultDict = value as! Dictionary<String, Any>
                    let postWithMessage = VideoListArray(data: resultDict)
                    completion(postWithMessage)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }

}
