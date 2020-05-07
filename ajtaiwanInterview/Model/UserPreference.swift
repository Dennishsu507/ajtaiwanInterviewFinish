//
//  UserPreference.swift
//  ajtaiwanInterview
//
//  Created by HSU, Hong-Wei on 2020/5/7.
//  Copyright © 2020 HSU, Hong-Wei. All rights reserved.
//

import Foundation
import UIKit

class MyFavorite {

    static let shared = MyFavorite()
    
    private let userPreferences: UserDefaults
    
    private init() {
        userPreferences = UserDefaults.standard
    }
    
    let saverKey = "FavoriteImageArray"
    static var imageUrlArray : [URL] = []
    static var imageStringArray : [String] = []
    
    private var isUpdated = false
    
    func setStringForKey() {
        userPreferences.set(MyFavorite.imageStringArray, forKey: saverKey)
    }
    
    func getStringForKey() {
        if let imageString = userPreferences.value(forKey: saverKey) as? [String] {
            MyFavorite.imageStringArray = imageString
        }
    }
    
    func updateImageStringArr(_ isUpdate : Bool) {
        self.isUpdated = isUpdate
    }
    
}
