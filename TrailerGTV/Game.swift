//
//  Game.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 02/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import Foundation
import UIKit

struct Game{
    var title: String
    var description: String
    var trailers: [String]
    var distribuidora: String
    var desenvolvedora: String
    var plataformas: [String]
    var genero: String
    var rank: String
    var faixaetaria: String
    var releaseDate: NSDate
    var imageURL: String
    
    init?(title: String, imageURL: String) {
//        guard let title = dictionary["title"] as? String, descripion = dictionary["description"] as? String, genre = dictionary["genre"] as? String, imageURL = dictionary["imageURL"] as? String, numPlayer = dictionary["numPlayer"]as? String, nameDevelop = dictionary["nameDevelop"]as? String, namePlatform = dictionary["numPlatform"]as? String, releaseDate = dictionary["releaseDate"]as? String else {
//            return nil
//        }
        
        
        self.title = title
        self.description = "descricao"
        self.trailers = [String]()
        trailers.append("ssb4trailer")
        self.distribuidora = "Distri"
        self.desenvolvedora = "Desenvolv"
        self.plataformas = [String]()
        self.plataformas.append("meme")
        self.genero = "not game"
        self.rank = "0 estrelas"
        self.faixaetaria = "PG13"
        self.releaseDate = NSDate.init(timeIntervalSinceNow: 0)
        self.imageURL = imageURL

        
    }
    mutating func setDetailInfo(desc: String, trailers: [String], distri: String, desenv: String, platf: [String], genero: String, rank: String, faixaetaria: String){
        self.description = desc
        self.desenvolvedora = desenv
        self.distribuidora = distri
        self.plataformas = platf
        self.genero = genero
        self.rank = rank
        self.faixaetaria = faixaetaria
        
    
    }
}

