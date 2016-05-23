//
//  Extensions.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 18/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import Foundation
extension Dictionary {
    
    static func loadJSONFromBundle(filename: String) -> Dictionary <String, AnyObject>? {
        
        var dataOK: NSData
        var dictionaryOK: NSDictionary = NSDictionary()
        let _: NSError?
        
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json", inDirectory: "Levels") {
            do {
                let data = try NSData(contentsOfFile: path, options: NSDataReadingOptions()) as NSData!
                dataOK = data
            }catch {
                print("Could not load file: \(filename), error: \(error)")
                return nil
            }
            do {
                let dictionary = try NSJSONSerialization.JSONObjectWithData(dataOK, options: NSJSONReadingOptions()) as AnyObject!
                dictionaryOK = (dictionary as! NSDictionary as? Dictionary < String, AnyObject>)!
            }catch {
                print("File '\(filename)' is not valid JSON: \(error)")
                return nil
            }
            
        }
        else{
            print("File '\(filename)' not found!")
        }
        return dictionaryOK as? Dictionary < String, AnyObject>
    }
}