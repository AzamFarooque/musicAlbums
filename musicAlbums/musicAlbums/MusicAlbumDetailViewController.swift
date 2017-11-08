//
//  MusicAlbumDetailViewController.swift
//  musicAlbums
//
//  Created by Farooque on 08/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit

class MusicAlbumDetailViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var model : MusicAlbumModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setImage(url: model.imageURLLarge)
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    // PRAGMA MARK : Hide StatusBar Hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    @IBAction func didTapCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
  
}
