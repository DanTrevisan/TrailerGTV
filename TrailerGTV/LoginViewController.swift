//
//  LoginViewController.swift
//  TrailerGTV
//
//  Created by Humberto  Julião on 16/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var cdWorker:CoreDataWorker!
    var users: NSArray!
    
//    @IBOutlet  colecao
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cdWorker = CoreDataWorker()
 //       users = cdWorker.usersArray

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toTabBar(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func novoUsuario(name: NSString){
 //       cdWorker.addUser(name as String)
//        colecao.reloadData()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
