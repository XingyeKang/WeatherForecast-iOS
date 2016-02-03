//
//  detailViewController.swift
//  WeatherForecast
//
//  Created by Xingye on 12/8/15.
//  Copyright © 2015 Xingye. All rights reserved.
//

import UIKit

class detailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func hourToDay(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if(index == 0){
            dayTableView.hidden = true
            hourTableView.hidden = false
        }else {
            dayTableView.hidden = false
            hourTableView.hidden = true
        }
    }
    
    @IBOutlet weak var hourTableView: UITableView!
    @IBOutlet weak var hourHeader: UIView!
    @IBOutlet weak var hourTitle: UILabel!
    
    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var dayHeader: UIView!
    @IBOutlet weak var dayTitle: UILabel!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var days:NSArray = NSArray() 
    var hours:NSArray = NSArray()
    var city = ""
    var state = ""
    var hourSwitch = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        //hourHeader.frame = CGRectMake(0, 0, 0.9*w, 50)
        //hourTableView.headerViewForSection(0) = hourHeader
        navigationBar.frame = CGRectMake(0, 0, w, 64)
        self.view.addSubview(navigationBar)
       
        hourTableView.frame = CGRectMake(0.05*w, 0 + 64, 0.9*w, 0.95*h - 64)
        self.view.addSubview(hourTableView)
        
        let tbw = hourTableView.frame.width
        //let tbh = hourTableView.frame.height
        
        hourHeader.frame = CGRectMake(0, 0, 0.9*tbw, 85)
        
        
        hourTitle.frame = CGRectMake(0.05*tbw, 0, 0.9*tbw, 50)
        hourTitle.text = "More Details for " + city + ", " + state
        hourTitle.font = UIFont(name: "Times", size: 23)
        hourHeader.addSubview(hourTitle)
        
        let titlebar1 = UILabel()
        titlebar1.frame = CGRectMake(0.1*tbw, 50, 0.3*tbw, 35)
        titlebar1.text = "Time"
        titlebar1.textAlignment = NSTextAlignment.Left
        hourHeader.addSubview(titlebar1)
        
        let titlebar2 = UILabel()
        titlebar2.frame = CGRectMake(0.35*tbw, 50, 0.3*tbw, 35)
        titlebar2.text = "Summary"
        titlebar2.textAlignment = NSTextAlignment.Center
        hourHeader.addSubview(titlebar2)
        
        let titlebar3 = UILabel()
        titlebar3.frame = CGRectMake(0.55*tbw, 50, 0.4*tbw, 35)
        titlebar3.text = "Temp(°F)"
        titlebar3.textAlignment = NSTextAlignment.Right
        hourHeader.addSubview(titlebar3)
        
        dayTableView.frame = CGRectMake(0.05*w, 64, 0.9*w, 0.85*h)
        self.view.addSubview(dayTableView)
        
        let tbhw = dayTableView.frame.width
        
        dayTitle.frame = CGRectMake(0.05*tbhw, 0, 0.9*tbhw, 50)
        dayTitle.text = "More Details for " + city + ", " + state
        dayTitle.font = UIFont(name: "Times", size: 23)
        dayHeader.addSubview(dayTitle)
        
        dayTableView.hidden = true
        hourTableView.hidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "")
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        
        let w = cell.frame.width
        let h = cell.frame.height
        
        if tableView.isEqual(self.hourTableView){
            let timeLabel = UILabel()
            let icon = UIImageView()
            let tempLabel = UILabel()
            if hourSwitch == 0{
            if indexPath.row == 24{
                let moreButton = UIButton(type: UIButtonType.ContactAdd)
                moreButton.frame = CGRectMake(0.55*w, 0, 30, 30)
                cell.addSubview(moreButton)
                moreButton.addTarget(self, action: "changeNums", forControlEvents: UIControlEvents.TouchUpInside)
            }
            else{
                
                if indexPath.row % 2 == 0 {
                    cell.backgroundColor = UIColor(red: 191/255, green: 192/255, blue: 191/255, alpha: 1)
                }
                
                timeLabel.frame = CGRectMake(0.1*w, 0, 0.33*w, h)
                timeLabel.textAlignment = NSTextAlignment.Left
                timeLabel.text = String(hours[indexPath.row].valueForKey("Time") as! NSString)
                cell.addSubview(timeLabel)
            
                icon.frame = CGRectMake(0.55*w, 0, 30, 30)
                icon.image = weatherImg((hours[indexPath.row].valueForKey("Summary") as! NSString) as String)
                cell.addSubview(icon)
            
                tempLabel.frame = CGRectMake(0.5*w, 0, 0.5*w, h)
                tempLabel.textAlignment = NSTextAlignment.Right
                tempLabel.text = String(hours[indexPath.row].valueForKey("Temp") as! NSString)
                cell.addSubview(tempLabel)
            }
            }else{
                
                if indexPath.row % 2 == 0 {
                    cell.backgroundColor = UIColor(red: 191/255, green: 192/255, blue: 191/255, alpha: 1)
                }
                
                timeLabel.frame = CGRectMake(0.1*w, 0, 0.33*w, h)
                timeLabel.textAlignment = NSTextAlignment.Left
                timeLabel.text = String(hours[indexPath.row].valueForKey("Time") as! NSString)
                cell.addSubview(timeLabel)
                
                icon.frame = CGRectMake(0.55*w, 0, 30, 30)
                icon.image = weatherImg((hours[indexPath.row].valueForKey("Summary") as! NSString) as String)
                cell.addSubview(icon)
                
                tempLabel.frame = CGRectMake(0.5*w, 0, 0.5*w, h)
                tempLabel.textAlignment = NSTextAlignment.Right
                tempLabel.text = String(hours[indexPath.row].valueForKey("Temp") as! NSString)
                cell.addSubview(tempLabel)

            }
        } else{
            let titleLabel = UILabel()
            let tempLabel = UILabel()
            let iconImg = UIImageView()
            
            let week = (days[indexPath.row].valueForKey("week") as! NSString) as String
            let day = (days[indexPath.row].valueForKey("day") as! NSString) as String
            let icon = (days[indexPath.row].valueForKey("icon") as! NSString) as String
            let maxTemp = (days[indexPath.row].valueForKey("hightemp") as! NSString) as String
            let minTemp = (days[indexPath.row].valueForKey("lowtemp")as! NSString) as String
            
            switch indexPath.row {
                case 0:
                    cell.backgroundColor = UIColor(red:251/255,green:213/255,blue:88/255,alpha: 1)
                    break
                case 1:
                    cell.backgroundColor = UIColor(red:145/255,green:226/255,blue:252/255,alpha: 1)
                    break
                case 2:
                    cell.backgroundColor = UIColor(red:241/255,green:179/255,blue:228/255,alpha: 1)
                    break
                case 3:
                    cell.backgroundColor = UIColor(red:183/255,green:248/255,blue:149/255,alpha: 1)
                    break
                case 4:
                    cell.backgroundColor = UIColor(red:242/255,green:173/255,blue:168/255,alpha: 1)
                    break
                case 5:
                    cell.backgroundColor = UIColor(red:234/255,green:251/255,blue:166/255,alpha: 1)
                    break
                default:
                    cell.backgroundColor = UIColor(red:174/255,green:174/255,blue:252/255,alpha: 1)
                    break
            }
            
            titleLabel.frame = CGRectMake(0.1*w, 10, 0.8*w, 40)
            titleLabel.text = week + ", " + day
            titleLabel.font = UIFont(name: "Times", size: 20)
            cell.addSubview(titleLabel)
            
            tempLabel.frame = CGRectMake(0.1*w, 55, 0.8*w, 40)
            tempLabel.text = "Min: " + minTemp + "°F | Max: " + maxTemp + "°F"
            tempLabel.font = UIFont(name: "Times", size: 20)
            cell.addSubview(tempLabel)
            
            iconImg.image = weatherImg(icon)
            iconImg.frame = CGRectMake(0.85*w, 10, 0.15*w, 0.15*w)
            cell.addSubview(iconImg)
        }
        return cell
    }
    
    func changeNums(){
        self.hourSwitch = 1
        self.hourTableView.reloadData()        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.isEqual(self.hourTableView){
            return 35
        } else {
            return 100
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEqual(self.hourTableView){
            if hourSwitch == 0 {
                return 25
            }else {
                return 48
            }
        }else {
            return 7
        }
    }
    
    func weatherImg(w : String) -> UIImage {
        var rs: UIImage = UIImage(named: "clear.png")!
        switch w{
        case "clear-day":
            rs = UIImage(named: "clear.png")!
            break
            
        case "clear-night":
            rs = UIImage(named: "clear_night.png")!
            break
            
        case "rain":
            rs = UIImage(named: "rain.png")!
            break
            
        case "snow":
            rs = UIImage(named: "snow.png")!
            break
            
        case "sleet":
            rs = UIImage(named: "sleet.png")!
            break
            
        case "wind":
            rs = UIImage(named: "wind.png")!
            break
            
        case "fog":
            rs = UIImage(named: "fog.png")!
            break
            
        case "cloudy":
            rs = UIImage(named: "cloudy.png")!
            break
            
        case "partly-cloudy-day":
            rs = UIImage(named: "cloud_day.png")!
            break
            
        case "partly-cloudy-night":
            rs = UIImage(named: "cloud_night.png")!
            break
            
        default:
            break
            
        }
        return rs
    }

    
}
