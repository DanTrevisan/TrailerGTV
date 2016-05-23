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
            gameName.text = game.title
            gameDescription.text = game.description
            gameGenres.text = game.genero.joinWithSeparator(", ")
            gamePlatforms.text = game.plataformas.joinWithSeparator(", ")
            gamePublisher.text = game.distribuidora.joinWithSeparator(", ")
            gameDeveloper.text = game.desenvolvedoras.joinWithSeparator(", ")
            gameReleaseDate.text = game.releaseDate.description
            
            
        }

    }
}