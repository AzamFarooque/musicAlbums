//
//  MusicAlbumDetailViewController.swift
//  musicAlbums
//
//  Created by Farooque on 04/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit

class MusicAlbumDetailViewController: UIViewController ,UIScrollViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var model:MusicAlbumModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setImage(url: model.imageURLLarge!)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.zoomScale = 1.0
        }
    
    // PRAGMA MARK : - ScrollView Delegate For Image Zoom
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // PRAGMA MARK : Hide StatusBar Hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // PRAGMA MARK : Back Button Action
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}
