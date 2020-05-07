//
//  FavoriteViewController.swift
//  ajtaiwanInterview
//
//  Created by HSU, Hong-Wei on 2020/5/7.
//  Copyright © 2020 HSU, Hong-Wei. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var favoriteCollectionLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        let itemSpace: CGFloat = 0
        let columnCount: CGFloat = 3
        let width = floor((favoriteCollectionView.bounds.width - itemSpace * (columnCount-1)) / columnCount)
        favoriteCollectionLayout.itemSize = CGSize(width: width, height: width)
        favoriteCollectionLayout.estimatedItemSize = .zero
        favoriteCollectionLayout.minimumInteritemSpacing = itemSpace
        favoriteCollectionLayout.minimumLineSpacing = itemSpace
        favoriteCollectionLayout.scrollDirection = .vertical
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.favoriteCollectionView.reloadData()
        
    }
}
//MARK: - collectionView

extension FavoriteViewController :  UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MyFavorite.imageStringArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        DispatchQueue.global().async {
            if let url = URL(string: MyFavorite.imageStringArray[indexPath.row]), let data = try?Data(contentsOf: url){
                DispatchQueue.main.async {
                    cell.favoriteImage.image = UIImage(data: data)
                    
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if let url = URL(string: MyFavorite.imageStringArray[indexPath.row]), let data = try?Data(contentsOf: url){
            desVC.imageData = data
        }
        present(desVC, animated: true)
    }
    
}
