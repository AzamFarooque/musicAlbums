//
//  UIView.swift
//  MyHealthPatient
//
//  Created by Farooque on 05/11/17.
//  Copyright © 2017 Farooque.
//

import UIKit

extension UIView {
    
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize.zero
        
    }

    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .white)

        if let _ = self.viewWithTag(200) as? UIActivityIndicatorView {
            
        } else {
            activityIndicator.center = self.center
            activityIndicator.color = UIColor.black
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 200
            self.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        if let activityIndicator = self.viewWithTag(200) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
