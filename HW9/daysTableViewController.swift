//
//  daysTableViewController.swift
//  WeatherForecast
//
//  Created by Xingye on 12/8/15.
//  Copyright © 2015 Xingye. All rights reserved.
//

import UIKit

class daysTableViewController: UITableViewController {
    
    var days:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(days)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }*/
}
