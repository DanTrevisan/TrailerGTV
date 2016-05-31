
//
//  SearchResultsCollectionViewController.swift
//  TrailerGTV
//
//  Created by Lidia Chou on 5/24/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchResultsCollectionViewController: UICollectionViewController {
    
    private let detailSegueIdentifier = "SearchDetail"
    var gameManager = GameService.sharedInstance
    private let reuseIdentifier = "GameCell"
    let jParser : JsonParser = JsonParser.init()
    var search: NSString = ""

    @IBOutlet weak var backgroundImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//        var blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        backgroundImage.addSubview(blurEffectView)
        
        tabBarController?.tabBar.items![0].title = "Destaques"
        tabBarController?.tabBar.items![1].title = "Categorias"
        tabBarController?.tabBar.items![2].title = "Busca"
        tabBarController?.tabBar.items![3].title = "Lista de Desejos"
        
        super.viewDidLoad()
        jParser.searchGames(search as String)
//        backgroundImage.image = UIImage(named: gameManager.games[0].imageURL)

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destinationViewController = segue.destinationViewController as?
            GameDetail, selectedIndex = collectionView?.indexPathsForSelectedItems()?.first {
            jParser.fetchGameData(selectedIndex.item)
            
            destinationViewController.game = gameManager.searchGames[selectedIndex.item]
            
        }
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(gameManager.searchGames.count)
        return gameManager.searchGames.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GameCollectionViewCell
        
        ImageLoader.sharedLoader.imageForUrl(gameManager.searchGames[indexPath.row].imageURL, completionHandler:{(image: UIImage?, url: String) in
            cell.gameImage.image = image
        })
        //cell.gameImage.image = UIImage(named: gameManager.games[indexPath.row].imageURL)
        cell.gameName.text = gameManager.searchGames[indexPath.row].title
        
        // Configure the cell
        
        return cell

    }
    
//    override func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
//        if (context.nextFocusedIndexPath != nil){
//            backgroundImage.image = UIImage(named: gameManager.games[(context.nextFocusedIndexPath?.row)!].imageURL)
//            
//        }
//        
//    }


}

extension SearchResultsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 525)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 90, bottom: 70, right: 90)
    }
}
