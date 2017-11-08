//
//  MusicAlbumSearchViewController.swift
//  musicAlbums
//
//  Created by Farooque on 05/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import Foundation
import expanding_collection


class MusicAlbumSearchViewController: ExpandingViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var musicAlbumArray : NSArray!
    var musicAlbumSearchArray : [MusicAlbumModel] = []
    
    
    let reuseIdentifier = "DemoCollectionViewCell"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        searchBar.autocorrectionType = .no
        self.searchBar.searchBarStyle = UISearchBarStyle.minimal
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
        textFieldInsideSearchBar?.backgroundColor = UIColor.white
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.frame.size.height = 0
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
                registerCell()
                itemSize = CGSize(width: 256, height: 335)
                addGesture(to: collectionView!)
                collectionView?.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: false)
        
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // PRAGMA MARK : Hide StatusBar Hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
extension MusicAlbumSearchViewController {
    
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

extension MusicAlbumSearchViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicAlbumSearchArray.count == 0 ? 0 : musicAlbumSearchArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DemoCollectionViewCell
        
        let section:MusicAlbumModel=musicAlbumSearchArray[indexPath.row]
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
extension MusicAlbumSearchViewController {
    
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



