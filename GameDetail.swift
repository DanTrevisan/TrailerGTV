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
    
    var game:Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDetail()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func playVideo(vidname: String) throws {
//        guard let path = NSData(contentsOfURL: NSURL.init(string: "http://v.giantbomb.com/video/tr_pokemon_20130108_1500.mp4")! )
// else {
//            throw AppError.InvalidResource(vidname, "mp4")
//        }
        let player = AVPlayer(URL:  NSURL(string: "http://v.giantbomb.com/video/tr_pokemon_20130108_1500.mp4?api_key=ac905e94dc4133129b73939d35fa7a4f1b3e94c7")!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true) {
            player.play()
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue,
                                  sender: AnyObject?) {
        // 1, 2
        if let destinationViewController = segue.destinationViewController as?
            MoreDetail{
           // jParser.fetchGameData(selectedIndex.item)
            // 3
            destinationViewController.game = game
            
        }
    }
    
    

}
private extension GameDetail{
    func setDetail(){
        
        if let game = game{
            
            gameName.text = game.title
            
            ImageLoader.sharedLoader.imageForUrl(game.imageURL, completionHandler:{(image: UIImage?, url: String) in
                self.backgroundImage.image = image
                self.imageView.image = self.backgroundImage.image

            })
            gameDesc.text = game.description
            namePlatform.text = game.plataformas.joinWithSeparator(", ")
            gameGenre.text = game.genero.joinWithSeparator(", ")
            //nameDevelop.text = game.desenvolvedoras.joinWithSeparator(", ")
            setRatingImage(game.faixaetaria)
            
            
            
        }
        
        else{
            
        }

    }
    
    func setRatingImage(ratingString: String){
        switch ratingString {
        case "ESRB: E":
            ratingImage.image = UIImage(named: "ratingsymbol_e")
            print("blas")
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
            try playVideo("ssb4trailer")
        } catch AppError.InvalidResource(let name, let type) {
            debugPrint("Could not find resource \(name).\(type)")
        } catch {
            debugPrint("Generic error")
        }
    }
    
    
}
