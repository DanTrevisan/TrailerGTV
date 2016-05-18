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
                                let id = dict2["name"] as? String
                                print("\(id)")
                                
                                let url = dict2["image"]!!["super_url"] as? String
                                print("\(url)")
                                if url != nil{
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
}


