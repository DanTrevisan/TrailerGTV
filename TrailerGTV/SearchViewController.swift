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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchField(sender: AnyObject) {
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "searchSegue") {
            if let destinationViewController: SearchResultsCollectionViewController = segue.destinationViewController as? SearchResultsCollectionViewController {
                let searchArray = txtSearch.text!.componentsSeparatedByString(" ")
                let searchString = searchArray.joinWithSeparator("%20")
                destinationViewController.search = searchString
                destinationViewController.searchText = txtSearch.text!
            }
        }
        
    }
 

}
