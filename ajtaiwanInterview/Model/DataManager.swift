//
//  DataManager.swift
//  ajtaiwanInterview
//
//  Created by HSU, Hong-Wei on 2020/5/5.
//  Copyright © 2020 HSU, Hong-Wei. All rights reserved.
//

import Foundation
import UIKit

protocol photoDelegate {
    func didUpdateModel(model : PhotoModel)
    func didFailWithError(title: String, error: Error)
}

struct photoManager {
    
    let flickrURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=2009f362b580ab6ab60ffd4241217b15"

    var delegate : photoDelegate?
    var delegateCollection : UICollectionViewDelegate?

    func fetchPhoto(text : String , perPage : String){
    let urlString = "\(flickrURL)&text=\(text)&per_page=\(perPage)&format=json&nojsoncallback=1"
    print(urlString)
    performRequest(with: urlString)
    }

    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    let errorCode = (error! as NSError).code
                    if errorCode == -1009{
                        DispatchQueue.main.async {
                            self.delegate?.didFailWithError(title: "No Internet Connection" , error: error!)
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.delegate?.didFailWithError(title: "Sorry", error: error!)
                        }
                    }
                    print("errorTask")
                }
                if let safeData = data{
                    if let photoModel = self.parseJson(safeData){
                        self.delegate?.didUpdateModel(model: photoModel)
                    }
                }
            }
            task.resume()
        } //performRequest
    }
    
    func parseJson(_ photoData:Data)->PhotoModel?{
        
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(ApiData.self, from: photoData)
            
            let decodePhotoModel = decodeData.photos.photo
            let photoModel = PhotoModel(photo: decodePhotoModel)
            return photoModel
            
        }catch{
            self.delegate?.didFailWithError(title:"Sorry", error: error)
            print("errorJSONDecoder")
            return nil
        }
    } //parseJson
    

} //manager

