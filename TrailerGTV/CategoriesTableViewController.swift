//
//  CategoriesTableViewController.swift
//  TrailerGTV
//
//  Created by Lidia Chou on 5/24/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let detailNav = splitViewController?.viewControllers.last as? UINavigationController {
            detailNav.popToRootViewControllerAnimated(true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let secondNav = splitViewController?.viewControllers.last as? UINavigationController
        let topview = secondNav?.topViewController as? CategoryCollectionViewController
        switch indexPath.item {
        case 0:
            topview?.updateGameData(CategoryType.DS3)
        case 1:
            topview?.updateGameData(CategoryType.PC)
        case 2:
            topview?.updateGameData(CategoryType.PS4)
        case 3:
            topview?.updateGameData(CategoryType.PSVita)
        case 4:
            topview?.updateGameData(CategoryType.XBoxOne)
        case 5:
            topview?.updateGameData(CategoryType.WiiU)
//        case 6:
//            topview?.updateGameData(CategoryType.AcaoAventura)
//        case 7:
//            topview?.updateGameData(CategoryType.BeatEm)
//        case 8:
//            topview?.updateGameData(CategoryType.Cartas)
//        case 9:
//            topview?.updateGameData(CategoryType.Corrida)
//        case 10:
//            topview?.updateGameData(CategoryType.Esportes)
//        case 11:
//            topview?.updateGameData(CategoryType.Estrategia)
//        case 12:
//            topview?.updateGameData(CategoryType.Ritmo)
//        case 13:
//            topview?.updateGameData(CategoryType.Luta)
//        case 14:
//            topview?.updateGameData(CategoryType.MMORPG)
//        case 15:
//            topview?.updateGameData(CategoryType.Plataforma)
//        case 16:
//            topview?.updateGameData(CategoryType.Shooter)
//        case 17:
//            topview?.updateGameData(CategoryType.Simuladores)
//        case 18:
//            topview?.updateGameData(CategoryType.FPS)
        default:
            print("nya")
    
        }

    }


}
