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
    var gameAPIstring: String
    var trailer: String
    var distribuidora: [String]
    var desenvolvedoras: [String]
    var plataformas: [String]
    var genero: [String]
    var rank: String
    var faixaetaria: String
    var releaseDate: String
    var imageURL: String
    
    init?(title: String, imageURL: String, gameString: String) {
//        guard let title = dictionary["title"] as? String, descripion = dictionary["description"] as? String, genre = dictionary["genre"] as? String, imageURL = dictionary["imageURL"] as? String, numPlayer = dictionary["numPlayer"]as? String, nameDevelop = dictionary["nameDevelop"]as? String, namePlatform = dictionary["numPlatform"]as? String, releaseDate = dictionary["releaseDate"]as? String else {
//            return nil
//        }
        
        
        self.title = title
        self.description = "descricao"
        self.trailer = "Vazio"
        self.gameAPIstring = gameString
        self.distribuidora = [String]()
        self.distribuidora.append("Not Found")
        self.desenvolvedoras = [String]()
        self.desenvolvedoras.append("Not found")
        self.plataformas = [String]()
        self.plataformas.append("meme")
        self.genero = [String]()
        self.genero.append("notgame")
        self.rank = "0 estrelas"
        self.faixaetaria = "PG13"
        self.releaseDate = "Não informada"
        self.imageURL = imageURL

        
    }
    mutating func setDetailInfo(desc: String, trailer: String, distri: [String], desenv: [String], platf: [String], generos: [String], rank: String, faixaetaria: String, releasedate: String){
        self.description = desc
        self.desenvolvedoras = desenv
        self.distribuidora = distri
        self.plataformas = platf
        self.genero = generos
        self.rank = rank
        self.faixaetaria = faixaetaria
        self.releaseDate = releasedate
        self.trailer = trailer
        
    
    }
}

