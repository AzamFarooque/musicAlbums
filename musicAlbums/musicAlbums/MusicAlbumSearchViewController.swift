//
//  MusicAlbumSearchViewController.swift
//  musicAlbums
//
//  Created by Farooque on 05/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import Foundation


class MusicAlbumSearchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var musicAlbumArray : NSArray!
    var musicAlbumSearchArray : [MusicAlbumModel] = []
    
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
        searchBar.becomeFirstResponder()
        searchBar.autocorrectionType = .no
        self.searchBar.searchBarStyle = UISearchBarStyle.minimal
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        headerView.addShadow()
        pageControl = UIPageControl()
        
        
    }
    
    // PRAGMA MARK : SearchBar Delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
        if searchBar.text != nil{
        fetchSearchResult(text: searchBar.text)
        }
     }
    
    func fetchSearchResult(text : String!){
        for index in 0...musicAlbumArray.count - 1{
            let section : MusicAlbumModel = musicAlbumArray[index] as! MusicAlbumModel
            if (section.title!.range(of: text) != nil){
             musicAlbumSearchArray +=  [section]
             collectionView.delegate = self
             collectionView.dataSource = self
             collectionView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: false)
        
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
    
    // PRAGMA MARK : : - UIScrollViewDelegate protocol
    
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
    
    
    
    // PRAGMA MARK :  : - CollectionView Deleagtes
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = musicAlbumSearchArray.count
        return musicAlbumSearchArray.count == 0 ? 0 : musicAlbumSearchArray.count
    }
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MusicAlbumCollectionViewCell
        cell.tag = indexPath.row
        cell.backgroundColor = UIColor.clear
        let section:MusicAlbumModel=musicAlbumSearchArray[indexPath.row] 
        cell.updateCell(model : section)
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(storyboard: .Main)
        let subsectionVC : MusicAlbumDetailViewController = storyboard.instantiateViewController()
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFromBottom
        subsectionVC.model = musicAlbumSearchArray[indexPath.row] 
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(subsectionVC, animated:false)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
