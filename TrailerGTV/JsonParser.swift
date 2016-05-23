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
                                
                                //Pega a url da Api do jogo, para conseguir os detalhes depois
                                let stringApi = dict2["api_detail_url"] as? String
                                let ranges = Range(stringApi!.startIndex.advancedBy(34)..<stringApi!.endIndex.advancedBy(-1))
                                
                                let stringGameID = stringApi?.substringWithRange(ranges)
                                print(stringGameID)
                                
                                
                                
                                
                                let url = dict2["image"]!!["super_url"] as? String
                                if url != nil{
                                    print("\(url!)")

                                    let game1:Game = Game.init(title: id! as String,imageURL: url!, gameString: stringGameID!)!
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
        let stringAPI = gameManager.games[gameindex].gameAPIstring
        //let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonData = NSData(contentsOfURL: NSURL.init(string: "http://www.giantbomb.com/api/game/" + stringAPI + "/?api_key=ac905e94dc4133129b73939d35fa7a4f1b3e94c7&format=json")! )
        do {
            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            if let dict = jsonResult as? [String: AnyObject] {
                print(dict["results"]!["name"])
                let dict2 = (dict["results"] as? NSDictionary)!
                
                //DESCRIÇÃO
                let desc = dict2["deck"] as? String
                
                //PLATAFORMAS
                let platforms = dict2["platforms"] as? NSArray
                var platformArray = [String]()
                for dictionaries in platforms!{
                    let platformsName = dictionaries["name"] as? String
                    platformArray.append(platformsName!)
                }
                
                //MARK: GENEROS (PS:Filtrar depois os gêneros indesejados)
                let generos = dict2["genres"] as? NSArray
                var generosArray = [String]()
                for dictionaries in generos!{
                    let generosName = dictionaries["name"] as? String
                    generosArray.append(generosName!)
                }
                
                //PUBLISHERS
                let publishers = dict2["publishers"] as? NSArray
                var publishersArray = [String]()
                for dictionaries in publishers!{
                    let publishersName = dictionaries["name"] as? String
                    publishersArray.append(publishersName!)
                }
                //DEVELOPERS
                let developers = dict2["developers"] as? NSArray
                var developersArray = [String]()
                for dictionaries in developers!{
                    let developersName = dictionaries["name"] as? String
                    developersArray.append(developersName!)
                }
                gameManager.games[gameindex].setDetailInfo  (desc!, trailers: platformArray, distri: publishersArray, desenv: developersArray, platf: platformArray, generos: generosArray, rank: "teste", faixaetaria: "teste")
                        
                }
        }catch {}
                    
//            }catch { "not found!"}
//        }

    }

    
}


