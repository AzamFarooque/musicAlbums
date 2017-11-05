//
//  UICollectionViewFlowLayout.swift
//  musicAlbums
//
//  Created by Farooque on 05/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit


let collectionMargin = CGFloat(50)
let itemSpacing = CGFloat(20)
let itemHeight = CGFloat(322)
var itemWidth = CGFloat(0)
var currentItem = 0

extension UICollectionView {
    
    
    func setup(collectionView : UICollectionView!) {
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

    
}
