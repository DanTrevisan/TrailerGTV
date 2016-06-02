
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
    var searchText: NSString = ""
    var number: NSString = ""

    @IBOutlet weak var backgroundImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.items![0].title = "Destaques"
        tabBarController?.tabBar.items![1].title = "Categorias"
        tabBarController?.tabBar.items![2].title = "Busca"
        tabBarController?.tabBar.items![3].title = "Lista de Desejos"
        
        super.viewDidLoad()
        jParser.searchGames(search as String)
        backgroundImage.image = UIImage(named: gameManager.games[0].imageURL)
        
        let num = gameManager.searchGames.count as NSNumber
        number = num.stringValue

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    // MARK: UICollectionViewDataSource

    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "searchReusableView", forIndexPath: indexPath) as! SearchCollectionReusableView
            headerView.searchLabel.text = "Sua busca: " + (searchText as String)
            headerView.numbersLabel.text = (number as String) + " resultados"
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
    
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
                
        return cell

    }
    
    override func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedIndexPath != nil){
            backgroundImage.image = UIImage(named: gameManager.searchGames[(context.nextFocusedIndexPath?.row)!].imageURL)
            
        }
        
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destinationViewController = segue.destinationViewController as?
            GameDetail, selectedIndex = collectionView?.indexPathsForSelectedItems()?.first {
            jParser.fetchGameData(selectedIndex.item, arrayName: "searchGames")
            
            destinationViewController.game = gameManager.searchGames[selectedIndex.item]
        }
    }


}

extension SearchResultsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 525)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 90, bottom: 70, right: 90)
    }
}
