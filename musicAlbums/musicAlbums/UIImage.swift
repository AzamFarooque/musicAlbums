//
//  UIImage.swift
//  FortisPatient
//
//  Created by Farooque on 05/11/17.
//  Copyright © 2017 Farooque.
//

import UIKit
import Alamofire
import AlamofireImage


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
