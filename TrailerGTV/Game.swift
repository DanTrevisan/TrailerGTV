//
//  Game.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 02/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import Foundation

struct Game{
    var title: String
//    var descripion: String
//    var genre: String
//    var numPlayer: String
//    var nameDevelop: String
//    var namePlatform: String
//    var releaseDate: String
    var imageURL: String
    
    init?(title: String, imageURL: String) {
//        guard let title = dictionary["title"] as? String, descripion = dictionary["description"] as? String, genre = dictionary["genre"] as? String, imageURL = dictionary["imageURL"] as? String, numPlayer = dictionary["numPlayer"]as? String, nameDevelop = dictionary["nameDevelop"]as? String, namePlatform = dictionary["numPlatform"]as? String, releaseDate = dictionary["releaseDate"]as? String else {
//            return nil
//        }
        
        self.title = title
//        self.descripion = descripion
//        self.genre = genre
        self.imageURL = imageURL
//        self.numPlayer = numPlayer
//        self.nameDevelop = nameDevelop
//        self.namePlatform = namePlatform
//        self.releaseDate = releaseDate
        
    }
}

