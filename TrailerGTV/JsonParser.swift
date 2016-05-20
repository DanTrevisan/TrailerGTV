//
//  JsonParser.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 18/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

class JsonParser{
    var gameManager = GameService.sharedInstance

    
    init(){
        if let path = NSBundle.mainBundle().pathForResource("JSONexemplo", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if let dict = jsonResult as? [String: AnyObject] {
                        if let results = dict["results"] as? [AnyObject] {
                            for dict2 in results {
                                
                                //Dá pra filtrar alguma coisa extra aqui
                                let id = dict2["name"] as? String
                                print("\(id!)")
                                
                                let url = dict2["image"]!!["super_url"] as? String
                                if url != nil{
                                    print("\(url!)")

                                    let game1:Game = Game.init(title: id! as String,imageURL: url!)!
                                    gameManager.games.append(game1)
                                }
                                
                                

                                
                            }
                        }
                    }
                    else{
                        print("Parameter not found!")
                    }
                    
                } catch {}
            } catch {}
        }
        else{
            print("File/path not found!")
        }
    }
    
    func fetchGameData(gameindex: Int){
        if let path = NSBundle.mainBundle().pathForResource("JSONexemplo", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if let dict = jsonResult as? [String: AnyObject] {
                        if let results = dict["results"] as? [AnyObject] {
                            for dict2 in results {
                                
                                let id = dict2["name"] as? String
                                //print("\(id!)")
                                
                                let url = dict2["image"]!!["super_url"] as? String
                                //print("\(url!)")
                                
                                
                                if id == gameManager.games[gameindex].title{
                                    let desc = dict2["deck"] as? String
                                    let platforms = dict2["platforms"] as? NSArray
                                    var platformArray = [String]()
                                    for dictionaries in platforms!{
                                        let platformsName = dictionaries["name"] as? String
                                        platformArray.append(platformsName!)

                                    }
                                    print(platformArray)
                                    
                                    gameManager.games[gameindex].setDetailInfo(desc!, trailers: platformArray, distri: "teste", desenv: "teste", platf: platformArray, genero: "teste", rank: "teste", faixaetaria: "teste")
                                    
                                    
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                    else{
                        print("Parameter not found!")
                    }
                    
                } catch {}
            } catch {}
        }
        else{
            print("File/path not found!")
        }

    }

    
}


