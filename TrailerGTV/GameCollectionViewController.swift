//
//  GameCollectionViewController.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 02/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

class GameCollectionViewController: UICollectionViewController {
    
    private let detailSegueIdentifier = "DetailSegue"
    var gameManager = GameService.sharedInstance
    private let reuseIdentifier = "GameCell"
    let jParser : JsonParser = JsonParser.init()

    @IBOutlet weak var backgroundImage: UIImageView!

    override func viewDidLoad() {
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImage.addSubview(blurEffectView)
        

        
        tabBarController?.tabBar.items![0].title = "Destaques"
        tabBarController?.tabBar.items![1].title = "Categorias"
        tabBarController?.tabBar.items![2].title = "Busca"
        tabBarController?.tabBar.items![3].title = "Lista de Desejos"


        

        self.setupExemplos()
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: gameManager.games[0].imageURL)
        
    


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupExemplos(){

    }

    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(gameManager.games.count)
        return gameManager.games.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GameCollectionViewCell
        
        ImageLoader.sharedLoader.imageForUrl(gameManager.games[indexPath.row].imageURL, completionHandler:{(image: UIImage?, url: String) in
            cell.gameImage.image = image
        })
        //cell.gameImage.image = UIImage(named: gameManager.games[indexPath.row].imageURL)
        cell.gameName.text = gameManager.games[indexPath.row].title
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedIndexPath != nil){
            backgroundImage.image = UIImage(named: gameManager.games[(context.nextFocusedIndexPath?.row)!].imageURL)

        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue,
                                  sender: AnyObject?) {
        // 1, 2
        if let destinationViewController = segue.destinationViewController as?
            GameDetail, selectedIndex = collectionView?.indexPathsForSelectedItems()?.first {
            jParser.fetchGameData(selectedIndex.item)
            print(selectedIndex.item)
            print(gameManager.games[selectedIndex.item].description)
            // 3
            destinationViewController.game = gameManager.games[selectedIndex.item]
            print(destinationViewController.game?.description)

        }
    }


}

extension GameCollectionViewController: UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 525)
    }
    
    // 3
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 90, bottom: 70, right: 90)
    }
}
extension GameCollectionViewController {
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(detailSegueIdentifier, sender: nil)
    }
}
