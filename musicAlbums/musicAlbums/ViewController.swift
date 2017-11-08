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
import expanding_collection

class ViewController: ExpandingViewController {
    var musicAlbumArray : NSArray!
    let reuseIdentifier = "DemoCollectionViewCell"
    @IBAction func didTapSearch(_ sender: Any) {
        
    let storyboard = UIStoryboard(storyboard: .Search)
    let subsectionVC : MusicAlbumSearchViewController = storyboard.instantiateViewController()
    let transition = CATransition()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.type = kCATransitionFromBottom
    subsectionVC.musicAlbumArray = musicAlbumArray
    self.navigationController?.view.layer.add(transition, forKey: nil)
    self.navigationController?.pushViewController(subsectionVC, animated:false)
        
    }
 }


   extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()


        registerCell()
        itemSize = CGSize(width: 256, height: 335)
        configureNavBar()
        addGesture(to: collectionView!)
        fetchStories()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"searchIcon"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black

    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func addTapped(){
        
        let storyboard = UIStoryboard(storyboard: .Search)
        let subsectionVC : MusicAlbumSearchViewController = storyboard.instantiateViewController()
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFromBottom
        subsectionVC.musicAlbumArray = musicAlbumArray
       self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(subsectionVC, animated:false)
        

    }
    
    // PRAGMA MARK :- Fetch Sample Data JSON
    
    func fetchStories(){
        self.view.showLoadingIndicator()
        MusicAlbumServices.fetchMusicAlbum(){ (responseObject:NSArray?, error:NSError?,total) in
            if ((error) != nil) {
                print("Error logging you in!")
            } else {
                print("got it..")
                self.view.hideLoadingIndicator()
                self.musicAlbumArray = responseObject
            }
        }
    }
    
    // PRAGMA MARK : Hide StatusBar Hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
}

    
extension ViewController {
    
    fileprivate func registerCell() {
        let nib = UINib(nibName: String(describing: DemoCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: DemoCollectionViewCell.self))
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController = storyboard.instantiateViewController()
        return toViewController
    }
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
}

// MARK: UICollectionViewDataSource

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicAlbumArray.count == 0 ? 0 : musicAlbumArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DemoCollectionViewCell
        
        let section:MusicAlbumModel=musicAlbumArray[indexPath.row] as! MusicAlbumModel
        cell.updateCell(model : section)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DemoCollectionViewCell
            , currentIndex == indexPath.row else { return }
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            
        } else {
            pushToViewController(getViewController())
            
        }
    }

}

/// MARK: Gesture
extension ViewController {
    
    fileprivate func addGesture(to view: UIView) {
        let upGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeHandler(_:)))) {
            $0.direction = .up
        }
        
        let downGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeHandler(_:)))) {
            $0.direction = .down
        }
        view.addGestureRecognizer(upGesture)
        view.addGestureRecognizer(downGesture)
    }
    
    func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell  = collectionView?.cellForItem(at: indexPath) as? DemoCollectionViewCell else { return }
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController())
                  }
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
    }
}


