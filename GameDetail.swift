//
//  GameDetail.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 02/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class GameDetail: UIViewController {
    
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameDesc: UILabel!
    @IBOutlet weak var gameGenre: UILabel!
    @IBOutlet weak var numPlayers: UILabel!
    @IBOutlet weak var namePlatform: UILabel!
    @IBOutlet weak var buttonWatch: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var buttonWishList: UIButton!
    
    var game:Game?
    let cdWorker = CoreDataWorker()
    var exibewishList = false
    var wishListIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDetail()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func playVideo(vidname: String) throws {
        
        print("URL: " + vidname + "?api_key=ac905e94dc4133129b73939d35fa7a4f1b3e94c7")

        let player = AVPlayer(URL:  NSURL(string: vidname + "?api_key=ac905e94dc4133129b73939d35fa7a4f1b3e94c7")!)
        
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true) {
            player.play()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as?
            MoreDetail{
           // jParser.fetchGameData(selectedIndex.item)
            destinationViewController.game = game
            if self.exibewishList == true {
                destinationViewController.exibewishList = true
                destinationViewController.wishListIndex = self.wishListIndex


            }
        }
    }

}
private extension GameDetail{
    func setDetail(){
        if let game = game{
            
            if exibewishList == false{
                gameName.text = game.title
            
                ImageLoader.sharedLoader.imageForUrl(game.imageURL, completionHandler:{(image: UIImage?, url: String) in
                    self.backgroundImage.image = image
                    self.imageView.image = self.backgroundImage.image
                
                })
            }
            else{
                let wishlistArray = cdWorker.gamesFromWishList()
                let gameWish = wishlistArray.objectAtIndex(wishListIndex) as? Games
                gameName.text = gameWish?.gameName
                
                ImageLoader.sharedLoader.imageForUrl((gameWish?.imageLink)!, completionHandler:{(image: UIImage?, url: String) in
                    self.backgroundImage.image = image
                    self.imageView.image = self.backgroundImage.image
                    
                })
                
            }
            gameDesc.text = game.description
            namePlatform.text = game.plataformas.joinWithSeparator(", ")
            gameGenre.text = game.genero.joinWithSeparator(", ")
            setRatingImage(game.faixaetaria)
            
            //Esconde o botão caso não tenha trailers
            if (game.trailer == "nil"){
                buttonWatch.hidden = true
            }else{
                buttonWatch.hidden = false
            }
            
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
    
    func setRatingImage(ratingString: String){
        switch ratingString {
        case "ESRB: E":
            ratingImage.image = UIImage(named: "ratingsymbol_e")
        case "ESRB: E10+":
            ratingImage.image = UIImage(named: "ratingsymbol_e10")
        case "ESRB: T":
            ratingImage.image = UIImage(named: "ratingsymbol_t")
        case "ESRB: M":
            ratingImage.image = UIImage(named: "ratingsymbol_m")
        default:
            ratingImage.image = UIImage(named: "ratingsymbol_rp")
        }
    }
    
    @IBAction func startTrailer(sender: AnyObject) {
        do {
            if let game = game{
                try playVideo(game.trailer)
            }
        } catch AppError.InvalidResource(let name, let type) {
            debugPrint("Could not find resource \(name).\(type)")
        } catch {
            debugPrint("Generic error")
        }
    }
    
    @IBAction func addToWishList(sender: AnyObject) {
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
