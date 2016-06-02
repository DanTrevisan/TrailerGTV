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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchField(sender: AnyObject) {
        activityIndicatorView.hidden = false
        activityIndicatorView.startAnimating()
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
