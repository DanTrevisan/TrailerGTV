//
//  MoreDetail.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 23/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

class MoreDetail : UIViewController{
    
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
    
    override func viewWillDisappear(animated: Bool) {
        self.splitViewController?.preferredDisplayMode = .PrimaryHidden
    }
    
}