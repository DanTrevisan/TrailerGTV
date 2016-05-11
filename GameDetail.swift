//
//  GameDetail.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 02/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit
import UIKit
import AVKit
import AVFoundation

class GameDetail: UIViewController {
    
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameDesc: UILabel!
    @IBOutlet weak var gameGenre: UILabel!
    @IBOutlet weak var numPlayers: UILabel!
    @IBOutlet weak var nameDevelop: UILabel!
    @IBOutlet weak var namePlatform: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var buttonWatch: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
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
        guard let path = NSBundle.mainBundle().pathForResource("ssb4trailer", ofType:"mp4") else {
            throw AppError.InvalidResource(vidname, "mp4")
        }
        let player = AVPlayer(URL: NSURL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true) {
            player.play()
        }
    }
    
    

}
private extension GameDetail{
    func setDetail(){
        
        if let game = game{
            gameName.text = game.title
            backgroundImage.image = UIImage(named: game.imageURL)
            imageView.image = backgroundImage.image
        }
        
        else{
        //TO DO: Dar setup propriamente nesses dados, pra deixas as informações dinâmicas, de acordo com a GameCollection
        
            gameName.text = "Super Smash Bros. for Wii U"
            gameDesc.text = "Nintendo All-stars in a all-out fighting game"
            gameGenre.text = "Fighting"
            numPlayers.text = "1-8 players"
            nameDevelop.text = "Nintendo"
            namePlatform.text = "Wii U"
            releaseDate.text = "30/12/2014"
            imageView.image = UIImage(named: "smashwiiu")
            backgroundImage.image = imageView.image
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
