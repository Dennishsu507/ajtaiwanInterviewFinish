//
//  DetailViewController.swift
//  ajtaiwanInterview
//
//  Created by HSU, Hong-Wei on 2020/5/5.
//  Copyright © 2020 HSU, Hong-Wei. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var imageData : Data?
    @IBOutlet weak var bigImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageData = imageData {
        bigImage.image = UIImage(data: imageData)
        }
      
    }
    

}
