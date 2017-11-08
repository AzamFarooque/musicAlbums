//
//  ViewController.swift
//  musicAlbums
//
//  Created by Farooque on 08/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import expanding_collection

class DemoTableViewController: ExpandingTableViewController {
   override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = false
    configureNavBar()
    headerHeight = 236
    //tableView.backgroundView = UIImageView(image: image1)
  }
  
  @IBOutlet weak var titleImageView: UIImageView!
  @IBOutlet weak var titleImageViewXConstraint: NSLayoutConstraint!
  
}

// MARK: - Lifecycle
extension DemoTableViewController {
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    guard let titleView = navigationItem.titleView else { return }
    let center = UIScreen.main.bounds.midX
    let diff = center - titleView.frame.midX
    titleImageViewXConstraint.constant = diff
  }
  
}

// MARK: Helpers
extension DemoTableViewController {
  
  fileprivate func configureNavBar() {
    navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
  }
  
}

// MARK: Actions
extension DemoTableViewController {
    
    func cancel(){
    popTransitionAnimation()
    }
  
  @IBAction func backButtonHandler(_ sender: AnyObject) {
    popTransitionAnimation()
  }
}


