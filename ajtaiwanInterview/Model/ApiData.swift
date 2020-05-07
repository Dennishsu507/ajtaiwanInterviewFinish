//
//  ApiData.swift
//  ajtaiwanInterview
//
//  Created by HSU, Hong-Wei on 2020/5/5.
//  Copyright © 2020 HSU, Hong-Wei. All rights reserved.
//

import Foundation

struct ApiData : Codable{
    let photos : Photos
}

struct Photos : Codable{
    let photo : [Photo]
}

struct Photo : Codable{
    let farm: Int
    let server: String
    let id: String
    let secret: String
    let title: String
    var imageUrl: URL {
          return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}



