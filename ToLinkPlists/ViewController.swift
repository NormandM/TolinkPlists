//
//  ViewController.swift
//  ToLinkPlists
//
//  Created by Normand Martin on 16-05-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var arr: NSMutableArray = []
var arr2: NSMutableArray = []
    var arrarr: [String] = []
    var arrarr2: [[String]] = []
    var arrTotal:[[String]] = []
    var n: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let plist = Plist(name: "2HumanPrehistory") {
            arr = plist.getMutablePlistFile()!
            n = arr.count
        }
        if let plist2 = Plist(name: "0HistoryOfUniverse") {
            arr2 = plist2.getMutablePlistFile()!
        }
        for arrs2 in arr2 {
            arr[n] = arrs2
        if let plist = Plist(name: "2HumanPrehistory"){
         do {
               try plist.addValuesToPlistFile(arr)
           } catch {
             print(error)
           }
        }
        n=n+1
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

