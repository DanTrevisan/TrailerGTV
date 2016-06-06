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
        default:
            print("nya")
    
        }

    }


}
