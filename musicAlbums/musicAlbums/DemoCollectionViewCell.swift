//
//  MusicAlbumCollectionViewCell.swift
//  musicAlbums
//
//  Created by Farooque on 04/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import expanding_collection

class DemoCollectionViewCell : BasePageCollectionCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var musicPublishYearLabel: UILabel!
    
    
    func updateCell(model : MusicAlbumModel){
         imageView.setImage(url: model.imageURLSmall)
//         title.text = model.title!
//         artistNameLabel.text = "Artist: "+model.artist!
//         musicPublishYearLabel.text = "Year: "+model.year!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
