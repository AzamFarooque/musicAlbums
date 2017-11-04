//
//  ViewController.swift
//  musicAlbums
//
//  Created by Farooque on 04/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var musicAlbumArray : NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStories()
    }
    
    // Pragma Mark :- Fetch Stories
    
    func fetchStories(){
        MusicAlbumServices.fetchStoriesList(){ (responseObject:NSArray?, error:NSError?,total) in
            if ((error) != nil) {
                print("Error logging you in!")
            } else {
                print("got it..")
                self.musicAlbumArray = responseObject
                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.reloadData()
        }
    }
}
    
    
    
    // Pragma Mark : - CollectionView Deleagtes
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicAlbumArray.count == 0 ? 0 : musicAlbumArray.count
    }
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicAlbumCollectionViewCell", for: indexPath as IndexPath) as! MusicAlbumCollectionViewCell
        
        let section:MusicAlbumModel=musicAlbumArray[indexPath.row] as! MusicAlbumModel
        cell.imageView.setImage(url: section.imageURLSmall)
     //    self.profileImageView.setImage(url: user?.profileImage)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}

extension UIImageView {
    
    func setImage(url : String?) {
        if let imageUrl = url {
            Alamofire.request(imageUrl).responseImage { response in
                if let image = response.result.value {
                    self.image = image
                }
            }
        }
    }
}

