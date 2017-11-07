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

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var musicAlbumArray : NSArray!
    var pageControl : UIPageControl!
    let collectionMargin = CGFloat(50)
    let itemSpacing = CGFloat(20)
    let itemHeight = CGFloat(322)
    let reuseIdentifier = "MusicAlbumCollectionViewCell"
    var itemWidth = CGFloat(0)
    var currentItem = 0
    var cell : MusicAlbumCollectionViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchStories()
        self.navigationController?.navigationBar.isHidden = true
        pageControl = UIPageControl()
        headerView.addShadow()
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
                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.reloadData()
        }
    }
}
   
   // PRAGMA MARK :- UICollectionViewFlowLayout setup
    
    func setup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        itemWidth =  UIScreen.main.bounds.width - collectionMargin * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
   //  PRAGMA MARK: - UIScrollViewDelegate protocol
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(self.pageControl.currentPage)
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    // PRAGMA MARK : - CollectionView Deleagtes
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         self.pageControl.numberOfPages = musicAlbumArray.count
        return musicAlbumArray.count == 0 ? 0 : musicAlbumArray.count
    }
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MusicAlbumCollectionViewCell
        cell.tag = indexPath.row
        cell.backgroundColor = UIColor.clear
        let section:MusicAlbumModel=musicAlbumArray[indexPath.row] as! MusicAlbumModel
        cell.updateCell(model : section)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.up
        self.cell.addGestureRecognizer(swipeLeft)

        return cell
    }
   
    func leftSwipe(indexPath : NSIndexPath){
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if cell.isExclusiveTouch == true{
       
       // let top = CGAffineTransform(translationX: 0, y: -300)
       
        UIView.animate(withDuration: 1.0, delay: 1.0, options: [], animations: {
       
        self.cell.frame.origin.y = -100
        }, completion: nil)
        }
        
//
//        let storyboard = UIStoryboard(storyboard: .Main)
//        let subsectionVC : MusicAlbumDetailViewController = storyboard.instantiateViewController()
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        transition.type = kCATransitionFromBottom
//        subsectionVC.model = musicAlbumArray[indexPath.row] as! MusicAlbumModel
//        self.navigationController?.view.layer.add(transition, forKey: nil)
//        self.navigationController?.pushViewController(subsectionVC, animated:false)
        
    }
    
    // PRAGMA MARK : - Search Action
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

