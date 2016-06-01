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

    }
    
    func getGames(){
        let original = "http://www.giantbomb.com/api/games/?api_key=ac905e94dc4133129b73939d35fa7a4f1b3e94c7&sort=original_release_date:asc&format=json&filter=platforms:146|139|145|117|129,expected_release_quarter:2"
        var jsonDatateste = NSData()
        if let encodedString = original.stringByAddingPercentEncodingWithAllowedCharacters(
            NSCharacterSet.URLFragmentAllowedCharacterSet()),
            url = NSURL(string: encodedString) {
            jsonDatateste = NSData(contentsOfURL: url )!
        }
        
        
        if let path = NSBundle.mainBundle().pathForResource("JSONexemplo", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonDatateste, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if let dict = jsonResult as? [String: AnyObject] {
                        if let results = dict["results"] as? [AnyObject] {
                            print(results.count)
                            for dict2 in results {
                                
                                //Dá pra filtrar alguma coisa extra aqui
                                let id = dict2["name"] as? String
                                
                                //Pega a url da Api do jogo, para conseguir os detalhes depois
                                let stringApi = dict2["api_detail_url"] as? String
                                let ranges = Range(stringApi!.startIndex.advancedBy(34)..<stringApi!.endIndex.advancedBy(-1))
                                
                                let stringGameID = stringApi?.substringWithRange(ranges)
                                
                                let url = dict2["image"]!!["super_url"] as? String
                                
                                if url != nil{
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
    
    func fetchGameData(gameindex: Int, arrayName: String){
        
        let stringAPI: String
        
        if (arrayName == "games") {
             stringAPI = gameManager.games[gameindex].gameAPIstring
        } else {
             stringAPI = gameManager.searchGames[gameindex].gameAPIstring
        }
        
        //let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonData = NSData(contentsOfURL: NSURL.init(string: "http://www.giantbomb.com/api/game/" + stringAPI + "/?api_key=ac905e94dc4133129b73939d35fa7a4f1b3e94c7&format=json")! )
        do {
            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            if let dict = jsonResult as? [String: AnyObject] {
                //print(dict["results"]!["name"])
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
                if publishers != nil {
                    for dictionaries in publishers!{
                        let publishersName = dictionaries["name"] as? String
                        publishersArray.append(publishersName!)
                    }
                }
                //DEVELOPERS
                let developers = dict2["developers"] as? NSArray
                var developersArray = [String]()
                if developers != nil {
                    for dictionaries in developers!{
                        let developersName = dictionaries["name"] as? String
                        developersArray.append(developersName!)
                    }
                }
                
                //RELEASE DATE ou EXPECTED RELEASE DATE
                var releaseDate = String()
                var trueData = NSDate()
                if (dict2["original_release_date"] as? String != nil){
                    //Se o jogo já saiu
                    let date1 = (dict2["original_release_date"] as? String)!
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    trueData = dateFormatter.dateFromString(date1)!
                    releaseDate = dateFormatter.stringFromDate(trueData)
                    
                }else{
                    //Se o jogo ainda não saiu (ainda não está considerando o atributo de trimestre (expected_release_quarter))
                    if (dict2["expected_release_day"] as? Int != nil){
                        let releaseday  = (dict2["expected_release_day"] as? Int)!
                        let releasemonth = (dict2["expected_release_month"] as? Int)!
                        let releaseyear  = (dict2["expected_release_year"] as? Int)!
                        releaseDate = String(releaseyear) + "-" + String(releasemonth) + "-" + String(releaseday)

                    }else if(dict2["expected_release_month"] as? Int != nil){
                        let releasemonth = (dict2["expected_release_month"] as? Int)!
                        let releaseyear  = (dict2["expected_release_year"] as? Int)!
                        releaseDate = String(releaseyear) + "-" + String(releasemonth)

                    }else if(dict2["expected_release_year"] as? Int != nil){
                        let releaseyear  = (dict2["expected_release_year"] as? Int)!
                        releaseDate = String(releaseyear)
                    
                    }else{
                     releaseDate = "Não informada!"
                    }
                }
                
                //RATING ESRB
                let ratings = dict2["original_game_rating"] as? NSArray
                var ratingString = String()
                if ratings != nil {
                    for dictionaries in ratings!{
                        let ratingID = dictionaries["id"] as? Int
                        if (ratingID == 6 || ratingID == 1 || ratingID == 29 || ratingID == 16){
                            ratingString = (dictionaries["name"] as? String)!
                        }
                    }
                }
                else{
                    ratingString = "Rating Pending"
                }
                
                //TRAILER
                let trailers = dict2["videos"] as? NSArray
                var gameTrailerString = String()
                if (trailers?.count > 0){
                    let vidDict = trailers?.objectAtIndex(0)
                    let TrailerString = (vidDict!["api_detail_url"] as? String)!
                    gameTrailerString = fetchVideoData(TrailerString)
                }
                else{
                    gameTrailerString = "nil"
                }
                print(gameTrailerString)
                
                if (arrayName == "games") {
                    gameManager.games[gameindex].setDetailInfo  (desc!, trailer: gameTrailerString, distri: publishersArray, desenv: developersArray, platf: platformArray, generos: generosArray, rank: "teste", faixaetaria: ratingString, releasedate: releaseDate)
                } else {
                    gameManager.searchGames[gameindex].setDetailInfo  (desc!, trailer: gameTrailerString, distri: publishersArray, desenv: developersArray, platf: platformArray, generos: generosArray, rank: "teste", faixaetaria: ratingString, releasedate: releaseDate)
                }
                
                        
                }
        }catch {}
        
    }
    
    func searchGames(searchString: String){
        let jsonData = NSData(contentsOfURL: NSURL.init(string: "http://www.giantbomb.com/api/search?api_key=ac905e94dc4133129b73939d35fa7a4f1b3e94c7&format=json&resources=game&query=" + searchString)! )
            do {
                gameManager.searchGames.removeAll()
                let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                if let dict = jsonResult as? [String: AnyObject] {
                    if let results = dict["results"] as? [AnyObject] {
                        print(results.count)
                        for dict2 in results {
                                
                            //Dá pra filtrar alguma coisa extra aqui
                            let id = dict2["name"] as? String
                                
                            //Pega a url da Api do jogo, para conseguir os detalhes depois
                            let stringApi = dict2["api_detail_url"] as? String
                            let ranges = Range(stringApi!.startIndex.advancedBy(34)..<stringApi!.endIndex.advancedBy(-1))
                            
                            let stringGameID = stringApi?.substringWithRange(ranges)
                                
                            let url = dict2["image"]!!["super_url"] as? String
                            if url != nil{
                                let game1:Game = Game.init(title: id! as String,imageURL: url!, gameString: stringGameID!)!
                                    gameManager.searchGames.append(game1)
                            }
                                
                        }
                    }
                }
                else{
                    print("Parameter not found!")
                }
                    
            } catch {}
    }

    func fetchVideoData(gameString: String) -> String{
        
        // TOMAR CUIDADO AQUI COM REQUISIÇÕES!! 
        var vidURL = String()
        let jsonData = NSData(contentsOfURL: NSURL.init(string: gameString + "?api_key=ac905e94dc4133129b73939d35fa7a4f1b3e94c7&format=json")! )
        do{
            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            if let dict = jsonResult as? [String: AnyObject] {
                let statuscode = dict["status_code"] as? Int!
                if  (statuscode == 1){
                    let dict2 = (dict["results"] as? NSDictionary)!
                    
                    vidURL = (dict2["high_url"] as? String)!
                }
                else{
                    vidURL = "nil"
                }
            }
        }catch{
                
        }
        return vidURL
       
    }

    
}


