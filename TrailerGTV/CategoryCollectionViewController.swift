//
//  CategoryCollectionViewController.swift
//  TrailerGTV
//
//  Created by Lidia Chou on 5/24/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

enum CategoryType {
    case DS3, PC, PS4, PSVita, XBoxOne, WiiU, AcaoAventura, BeatEm, Cartas, Corrida, Esportes, Estrategia, Ritmo, Luta, MMORPG, Plataforma, Puzzle, Shooter, Simuladores, FPS
    
}

class CategoryCollectionViewController: UICollectionViewController {
    
    private let detailSegueIdentifier = "categoriaDetail"
    var gameManager = GameService.sharedInstance
    private let reuseIdentifier = "GameCell"
    let jParser : JsonParser = JsonParser.init()
    var games = [Game]()
    
    @IBOutlet weak var backgroundImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.items![0].title = "Destaques"
        tabBarController?.tabBar.items![1].title = "Categorias"
        tabBarController?.tabBar.items![2].title = "Busca"
        tabBarController?.tabBar.items![3].title = "Lista de Desejos"
        
        super.viewDidLoad()
//        backgroundImage.image = UIImage(named: gameManager.games[0].imageURL)

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    override func viewWillAppear(animated: Bool) {
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width/4, height: 525);
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return games.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GameCollectionViewCell
        
        ImageLoader.sharedLoader.imageForUrl(games[indexPath.row].imageURL, completionHandler:{(image: UIImage?, url: String) in
            cell.gameImage.image = image
        })
        cell.gameName.text = games[indexPath.row].title
        return cell

    }
    
    func updateGameData(categoria: CategoryType){
            games = jParser.showGameByPlatform(categoria)
            self.collectionView?.reloadData()

        
    }
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destinationViewController = segue.destinationViewController as?
            GameDetail, selectedIndex = collectionView?.indexPathsForSelectedItems()?.first {
            jParser.fetchGameData(selectedIndex.item, arrayName: "categoryGames")
            destinationViewController.exibewishList = false
            destinationViewController.game = gameManager.categoryGames[selectedIndex.item]
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryHidden
        //self.splitViewController.

    }


}

extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 300, height: 525)
//    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 90, bottom: 70, right: 90)
    }
    
}
