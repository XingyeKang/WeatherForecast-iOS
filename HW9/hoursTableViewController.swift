//
//  hoursTableViewController.swift
//  WeatherForecast
//
//  Created by Xingye on 12/8/15.
//  Copyright © 2015 Xingye. All rights reserved.
//

import UIKit

class hoursTableViewController: UITableViewController {
    
    var hours:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(hours)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }

    @IBAction func unwindToList(segue: UIStoryboardSegue){
        let source = segue.sourceViewController as! ResultActivityViewController
        
        hours = source.hoursDic
        
        print(hours)
        
        
    }*/
}
