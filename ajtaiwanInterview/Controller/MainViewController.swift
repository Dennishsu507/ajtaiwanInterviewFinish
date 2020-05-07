//
//  MainViewController.swift
//  ajtaiwanInterview
//
//  Created by HSU, Hong-Wei on 2020/5/5.
//  Copyright © 2020 HSU, Hong-Wei. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var request : String?
    var perPage : String?
    
    
    var myPhotoManager = photoManager()
    var myPhotoModel : PhotoModel?{
        didSet{
            didUpdateUI()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myPhotoManager.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let request = request, let perPage = perPage{
        myPhotoManager.fetchPhoto(text: request,perPage: perPage)
        }
        
        navigationItem.title = "#\(request ?? "noPhoto" )"
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        let itemSpace: CGFloat = 0
        let columnCount: CGFloat = 3
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount-1)) / columnCount)
        collectionLayout.itemSize = CGSize(width: width, height: width)
        collectionLayout.estimatedItemSize = .zero
        collectionLayout.minimumInteritemSpacing = itemSpace
        collectionLayout.minimumLineSpacing = itemSpace
        collectionLayout.scrollDirection = .vertical
    }
    
    

    func didUpdateUI(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}
//MARK: - photoDelegate

extension MainViewController : photoDelegate{
    func didUpdateModel(model: PhotoModel) {
        self.myPhotoModel = model
        print("getModel")
    }
    
    func didFailWithError(title:String,error: Error) {
        let alert = UIAlertController(title: title, message: "Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        print(error)
    }
}


//MARK: - collectionViewDelegate

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let myPhotoModel = self.myPhotoModel else {return 0}
        return myPhotoModel.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        DispatchQueue.global().async {
            if let model = self.myPhotoModel, let data = try?Data(contentsOf: model.photo[indexPath.row].imageUrl){
                DispatchQueue.main.async {
                    cell.cellImage.image = UIImage(data: data)
                    cell.titleLabel.text = model.photo[indexPath.row].title
                    cell.heartButton.tag = indexPath.row
                }
            }
        }
        return cell
    }
    
 //MARK: - add / remove my favorite
    
    @IBAction func changHeartButtonImage(_ sender: UIButton) {
        if sender.isSelected == false {
            if let model = self.myPhotoModel {
                let url = model.photo[sender.tag].imageUrl
                let imageString = url.absoluteString
                MyFavorite.imageStringArray.append(imageString)
            }
        } else {
            if let model = self.myPhotoModel {

                let url = model.photo[sender.tag].imageUrl
                let imageString = url.absoluteString
                    MyFavorite.imageStringArray = MyFavorite.imageStringArray.filter({$0 != imageString})
                }
            }
        sender.isSelected = !sender.isSelected

        MyFavorite.shared.setStringForKey()

    }
    
}


