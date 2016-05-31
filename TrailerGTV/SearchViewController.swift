//
//  SearchViewController.swift
//  TrailerGTV
//
//  Created by Lidia Chou on 5/24/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchField(sender: AnyObject) {
//        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let searchResults: SearchResultsCollectionViewController = storyboard.instantiateViewControllerWithIdentifier("searchResults") as! SearchResultsCollectionViewController
//        
//        presentViewController(searchResults, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "searchSegue") {
            if let destinationViewController: SearchResultsCollectionViewController = segue.destinationViewController as? SearchResultsCollectionViewController {
                destinationViewController.search = txtSearch.text!
            }
        }
        
    }
 

}
