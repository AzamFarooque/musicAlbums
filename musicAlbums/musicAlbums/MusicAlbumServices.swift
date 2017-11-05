//
//  MusicAlbumServices.swift
//  musicAlbums
//
//  Created by Farooque on 04/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponseArray = (NSArray?, NSError?,NSInteger) -> Void

final class MusicAlbumServices {
    
    class func fetchMusicAlbum(onCompletion: ServiceResponseArray){
        if let path = Bundle.main.path(forResource: "sample-data", ofType: "json") {
            do {
                let url = NSURL(fileURLWithPath: path)
                let data = try NSData(contentsOf: url as URL , options : NSData.ReadingOptions.dataReadingMapped)
                let jsonObj = JSON(data: data as Data)
                print(JSON.self)
                if jsonObj != JSON.null {
                    let modelArray = mapDataToModel(albumList: jsonObj.arrayObject! as NSArray)
                    onCompletion(modelArray,nil,1)
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error)
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
    
    private class func mapDataToModel (albumList : NSArray)-> NSArray {
        let modelArray:NSMutableArray=NSMutableArray()
        for userData in albumList {
            let user:MusicAlbumModel=MusicAlbumModel(json: userData as! NSDictionary)
            modelArray.add(user)
        }
        return modelArray
    }
}


