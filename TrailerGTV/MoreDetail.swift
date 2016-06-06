//
//  MoreDetail.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 23/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

class MoreDetail : UIViewController, UIGestureRecognizerDelegate, UISplitViewControllerDelegate{
    
    var game:Game?
    var exibewishList = false
    var wishListIndex = Int()
    let cdWorker = CoreDataWorker()


    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameGenres: UILabel!
    @IBOutlet weak var gamePlatforms: UILabel!
    @IBOutlet weak var gamePublisher: UILabel!
    @IBOutlet weak var gameDeveloper: UILabel!
    @IBOutlet weak var gameReleaseDate: UILabel!
    @IBOutlet weak var gameRating: UIImageView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var buttonWishList: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInfos()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadInfos(){
        if let game = game{
            if (exibewishList == true){
                let wishlistArray = cdWorker.gamesFromWishList()
                let gameWish = wishlistArray.objectAtIndex(wishListIndex) as? Games
                gameName.text = gameWish?.gameName
            }else{
                gameName.text = game.title

            }
            gameDescription.text = game.description
            gameGenres.text = game.genero.joinWithSeparator(", ")
            gamePlatforms.text = game.plataformas.joinWithSeparator(", ")
            gamePublisher.text = game.distribuidora.joinWithSeparator(", ")
            gameDeveloper.text = game.desenvolvedoras.joinWithSeparator(", ")
            
            //print(game.releaseDate)
            if game.releaseDate != "Não informada" {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy"
                var strDate = dateFormatter.dateFromString(game.releaseDate)
                gameReleaseDate.text = game.releaseDate

                if (strDate == nil){
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    strDate = dateFormatter.dateFromString(game.releaseDate)
                    if (strDate == nil){
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:s"
                        strDate = dateFormatter.dateFromString(game.releaseDate)
                        if (strDate == nil){
                            dateFormatter.dateFormat = "yyyy"
                            strDate = dateFormatter.dateFromString(game.releaseDate)
                        }
                    }
                    let segstring = convertDateFormater(strDate!)
                    gameReleaseDate.text = segstring
                }
                
            }
            else{
                gameReleaseDate.text = game.releaseDate
            }
            setRatingImage(game.faixaetaria)
            
            if( exibewishList == true){
                let wishlistArray = cdWorker.gamesFromWishList()
                let gameWish = wishlistArray.objectAtIndex(wishListIndex) as? Games
                if cdWorker.searchByID((gameWish?.idGame)!)==false{
                    buttonWishList.setTitle("+ Lista de Desejos", forState: UIControlState.Normal)
                }else{
                    buttonWishList.setTitle("- Lista de Desejos", forState: UIControlState.Normal)
                }
            }else{
                if cdWorker.searchByID(game.gameAPIstring)==false{
                    buttonWishList.setTitle("+ Lista de Desejos", forState: UIControlState.Normal)
                }else{
                    buttonWishList.setTitle("- Lista de Desejos", forState: UIControlState.Normal)
                }
            }
        }

    }
    
    func convertDateFormater(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        
        dateFormatter.locale = NSLocale(localeIdentifier: "pt_BR")
        
        let timeStamp = dateFormatter.stringFromDate(date)
        
        return timeStamp
    }
    
    func setRatingImage(ratingString: String){
        switch ratingString {
        case "ESRB: E":
            gameRating.image = UIImage(named: "ratingsymbol_e")
        case "ESRB: E10+":
            gameRating.image = UIImage(named: "ratingsymbol_e10")
        case "ESRB: T":
            gameRating.image = UIImage(named: "ratingsymbol_t")
        case "ESRB: M":
            gameRating.image = UIImage(named: "ratingsymbol_m")
        default:
            gameRating.image = UIImage(named: "ratingsymbol_rp")
            
        }
    }
    
    @IBAction func tapGestureAction(sender: UITapGestureRecognizer) {
        if sender.state == .Recognized {
            let pressType = UIPressType(rawValue:
                sender.allowedPressTypes.first!.integerValue)!
            if (pressType == UIPressType.Menu){
                self.navigationController?.popViewControllerAnimated(true)
            }
        }


    }
    
    @IBAction func addWishlist(sender: AnyObject) {
        if let gameLet = game{
            if exibewishList == false{
                if cdWorker.searchByID(gameLet.gameAPIstring) {
                    cdWorker.removeGameFromWishList(gameLet.gameAPIstring)
                    buttonWishList.setTitle("+ Lista de Desejos", forState: UIControlState.Normal)
                    
                }else{
                    cdWorker.addGameToWishList(gameLet.gameAPIstring, name: gameLet.title, imageLink: gameLet.imageURL)
                    buttonWishList.setTitle("- Lista de Desejos", forState: UIControlState.Normal)
                }
            }
            else{
                let wishlistArray = cdWorker.gamesFromWishList()
                let gameWish = wishlistArray.objectAtIndex(wishListIndex) as? Games
                if cdWorker.searchByID((gameWish?.idGame)!) {
                    print("apistring: " + (gameWish?.idGame)!)
                    
                    cdWorker.removeGameFromWishList((gameWish?.idGame)!)
                    buttonWishList.setTitle("+ Lista de Desejos", forState: UIControlState.Normal)
                    
                    navigationController!.popViewControllerAnimated(true)
                    
                }else {
                    cdWorker.addGameToWishList((gameWish?.idGame)!, name: (gameWish?.gameName)!, imageLink: (gameWish?.imageLink)!)
                    buttonWishList.setTitle("- Lista de Desejos", forState: UIControlState.Normal)
                }
            }
        }
    }
    
    
}