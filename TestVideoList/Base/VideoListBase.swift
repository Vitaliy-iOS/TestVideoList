//
//  VideoListBase.swift
//  TestVideoList
//
//  Created by Admin on 09.04.2020.
//  Copyright © 2020 KorefeyGroup. All rights reserved.
//

import UIKit
import SwiftyJSON

struct VideoListArray {
    var listBaseArr = [VideoListBase]()

    init(data: Any) {
        let json = JSON(data)
        for item in json["data"].arrayValue {
            listBaseArr.append(VideoListBase.init(data: item))
        }
    }
}

struct VideoListBase {
    var id: String
    var username: String
    var title: String
    var imageUrl: String
    
    init(data: Any) {
        let json = JSON(data)

        self.id = json["id"].stringValue
        self.username = json["username"].stringValue
        self.title = json["title"].stringValue
        if let tempImages = json["images"]["fixed_height_small_still"]["url"].string {
            self.imageUrl = tempImages
        } else {
            self.imageUrl = ""
        }
        
    }
    
    init() {
        id = ""
        username = ""
        title = ""
        imageUrl = ""
    }
}
