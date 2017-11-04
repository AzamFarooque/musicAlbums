//
//  MusicAlbumModel.swift
//  musicAlbums
//
//  Created by Farooque on 04/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import Foundation

class MusicAlbumModel: NSObject {
    
    var title : String?
    var genre : String?
    var artist : String?
    var year : String?
    var review : String?
    var audioURL : String?
    var imageURLSmall : String?
    var imageURLLarge : String?
    
    init(json: NSDictionary) {
        self.title = json["title"] as? String
        self.genre = json["genre"] as? String
        self.artist = json["artist"] as? String
        self.year = json["year"] as? String
        self.review = json["review"] as? String
        self.audioURL = json["audioURL"] as? String
        self.imageURLSmall = json["imageURLSmall"] as? String
        self.imageURLLarge = json["imageURLLarge"] as? String
    }
}
