//
//  ResultActivityViewController.swift
//  WeatherForecast
//
//  Created by Xingye on 12/7/15.
//  Copyright © 2015 Xingye. All rights reserved.
//

import UIKit

import FBSDKShareKit
import FBSDKLoginKit


class ResultActivityViewController: UIViewController,FBSDKSharingDelegate {

    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var highlowLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var dewpointLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var precipitationResult: UILabel!
    @IBOutlet weak var rainResult: UILabel!
    @IBOutlet weak var windResult: UILabel!
    @IBOutlet weak var dewpointResult: UILabel!
    @IBOutlet weak var humidityResult: UILabel!
    @IBOutlet weak var visibilityResult: UILabel!
    @IBOutlet weak var sunriseResult: UILabel!
    @IBOutlet weak var sunsetResult: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!

    @IBOutlet weak var fbbtn: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    //facebook
    let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
    var FBsummary = ""
    var FBweathericon = ""
    var FBtemperature = ""
    let button : FBSDKShareButton = FBSDKShareButton()
    
    //weatherMap
    var lat:Double = 0
    var lon:Double = 0
    
    var street = ""
    var city = ""
    var state = ""
    var degree = ""
    
    //var APIURL = "http://homework10-env.elasticbeanstalk.com/index.php?street=325+w+adams+blvd&city=Los+Angeles&states=CA&temp=us"
    var APIURL = ""
    var WeatherDataSource = []
    
    var currentDic:NSDictionary = NSDictionary()
    var dayArray:NSMutableArray = []
    var hourArray:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*dispatch_async(dispatch_get_main_queue(), {
            
        })
        dispatch_async(dispatch_get_main_queue(), {
            
        })*/
        print(dayArray)
        
        self.loadWeather()
        //self.loadWeatherForecast()
        self.initAll()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initAll(){
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        //navigation
        navigationBar.frame = CGRectMake(0, 0, w, 64)
        self.view.addSubview(navigationBar)
        
        //bg blue view
        let bgview = UIImageView()
        bgview.frame = self.view.bounds
        bgview.image = UIImage(named: "sky.jpg")
        //self.view.addSubview(bgview)
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
        blurView.frame = self.view.bounds
        blurView.alpha = 0.7
        //self.view.addSubview(blurView)
        
        mainScrollView.frame = CGRectMake(0, 64, w, h)
        mainScrollView.contentSize = CGSize(width: w, height: 1.5*h)
        mainScrollView.scrollEnabled = true
        mainScrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(mainScrollView)
        
        //facebook
        self.fbbtn.frame = CGRectMake(0.05 * self.view.frame.width + 250, 10, 30, 30)
        self.fbbtn.addTarget(self, action: "fbshare", forControlEvents: UIControlEvents.TouchUpInside)
        self.mainScrollView.addSubview(self.fbbtn)

        
        /*
        //facebook
        content.contentURL = NSURL(string: "https://forecast.io")
        content.contentTitle = "Current Weather in " + city + ", " + state
        content.contentDescription = self.FBsummary + ", " + self.FBtemperature
        content.imageURL = NSURL(string: self.FBweathericon)
        
        print(self.FBsummary + "," + self.FBtemperature + "," + self.FBweathericon)

        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRectMake(0.05*w+250, 10, 100, 30)
        mainScrollView.addSubview(button)
        */
        
        detailButton.frame = CGRectMake(0.05*w, 10, 130, 30)
        detailButton.backgroundColor = UIColor.lightGrayColor()
        detailButton.titleLabel?.backgroundColor = UIColor.lightGrayColor()
        detailButton.titleLabel?.textAlignment = NSTextAlignment.Center
        detailButton.titleLabel?.textColor = UIColor.whiteColor()
        mainScrollView.addSubview(detailButton)
        
        mapButton.frame = CGRectMake(0.05*w+140, 10, 100, 30)
        mapButton.backgroundColor = UIColor.lightGrayColor()
        mapButton.titleLabel?.backgroundColor = UIColor.lightGrayColor()
        mapButton.titleLabel?.textAlignment = NSTextAlignment.Center
        mapButton.titleLabel?.textColor = UIColor.whiteColor()
        mainScrollView.addSubview(mapButton)
        
        //fbButton.frame = CGRectMake(0.05*w+250, 10, 30, 30)
        //mainScrollView.addSubview(fbButton)
        
        iconImg.frame = CGRectMake(0.25*w, 0.1*h, 0.5*w, 0.5*w)
        //iconImg.image = UIImage(named: "clear.png")
        mainScrollView.addSubview(iconImg)
        
        summaryLabel.frame = CGRectMake(0, 0.4*h, w, 35)
        summaryLabel.textAlignment = NSTextAlignment.Center
        //summaryLabel.text = "Clear in Los Angeles, CA"
        summaryLabel.font = UIFont(name: "Times", size: 25)
        mainScrollView.addSubview(summaryLabel)
        
        tempLabel.frame = CGRectMake(0, 0.46*h, w, 35)
        tempLabel.textAlignment = NSTextAlignment.Center
        //tempLabel.text = "68°F"
        tempLabel.font = UIFont(name: "Times", size: 30)
        mainScrollView.addSubview(tempLabel)
        
        highlowLabel.frame = CGRectMake(0, 0.52*h, w, 35)
        highlowLabel.textAlignment = NSTextAlignment.Center
        highlowLabel.font = UIFont(name: "Times", size: 23)
        //highlowLabel.text = "L:48°|H:71°"
        mainScrollView.addSubview(highlowLabel)
        
        precipitationLabel.frame = CGRectMake(0.1*w, 0.6*h, 0.4*w, 30)
        precipitationLabel.textAlignment = NSTextAlignment.Left
        precipitationLabel.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(precipitationLabel)
        
        precipitationResult.frame = CGRectMake(0.5*w, 0.6*h, 0.4*w, 30)
        precipitationResult.textAlignment = NSTextAlignment.Right
        precipitationResult.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(precipitationResult)
        
        rainLabel.frame = CGRectMake(0.1*w, 0.7*h, 0.4*w, 30)
        rainLabel.textAlignment = NSTextAlignment.Left
        rainLabel.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(rainLabel)
        
        rainResult.frame = CGRectMake(0.5*w, 0.7*h, 0.4*w, 30)
        rainResult.textAlignment = NSTextAlignment.Right
        rainResult.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(rainResult)
        
        windLabel.frame = CGRectMake(0.1*w, 0.8*h, 0.4*w, 30)
        windLabel.textAlignment = NSTextAlignment.Left
        windLabel.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(windLabel)
        
        windResult.frame = CGRectMake(0.5*w, 0.8*h, 0.4*w, 30)
        windResult.textAlignment = NSTextAlignment.Right
        windResult.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(windResult)
        
        dewpointLabel.frame = CGRectMake(0.1*w, 0.9*h, 0.4*w, 30)
        dewpointLabel.textAlignment = NSTextAlignment.Left
        dewpointLabel.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(dewpointLabel)
        
        dewpointResult.frame = CGRectMake(0.5*w, 0.9*h, 0.4*w, 30)
        dewpointResult.textAlignment = NSTextAlignment.Right
        dewpointResult.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(dewpointResult)
        
        humidityLabel.frame = CGRectMake(0.1*w, h, 0.4*w, 30)
        humidityLabel.textAlignment = NSTextAlignment.Left
        humidityLabel.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(humidityLabel)
        
        humidityResult.frame = CGRectMake(0.5*w, 1*h, 0.4*w, 30)
        humidityResult.textAlignment = NSTextAlignment.Right
        humidityResult.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(humidityResult)
        
        visibilityLabel.frame = CGRectMake(0.1*w, 1.1*h, 0.4*w, 30)
        visibilityLabel.textAlignment = NSTextAlignment.Left
        visibilityLabel.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(visibilityLabel)
        
        visibilityResult.frame = CGRectMake(0.5*w, 1.1*h, 0.4*w, 30)
        visibilityResult.textAlignment = NSTextAlignment.Right
        visibilityResult.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(visibilityResult)
        
        sunriseLabel.frame = CGRectMake(0.1*w, 1.2*h, 0.4*w, 30)
        sunriseLabel.textAlignment = NSTextAlignment.Left
        sunriseLabel.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(sunriseLabel)
        
        sunriseResult.frame = CGRectMake(0.5*w, 1.2*h, 0.4*w, 30)
        sunriseResult.textAlignment = NSTextAlignment.Right
        sunriseResult.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(sunriseResult)
        
        sunsetLabel.frame = CGRectMake(0.1*w, 1.3*h, 0.4*w, 30)
        sunsetLabel.textAlignment = NSTextAlignment.Left
        sunsetLabel.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(sunsetLabel)
        
        sunsetResult.frame = CGRectMake(0.5*w, 1.3*h, 0.4*w, 30)
        sunsetResult.textAlignment = NSTextAlignment.Right
        sunsetResult.font = UIFont(name: "Times", size: 23)
        mainScrollView.addSubview(sunsetResult)
        
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
    
    
    func loadWeather(){
        let nsurl = NSURL(string: APIURL)
        let nsurlrq = NSURLRequest(URL: nsurl!)
        //let queue = NSOperationQueue()
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(nsurlrq, completionHandler: {(data, response, error) -> Void in
            
            session.finishTasksAndInvalidate()
            
            let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSObject
            
            let current = json!.valueForKey("current") as! NSDictionary
            let days = json!.valueForKey("days") as! NSArray
            let hours = json!.valueForKey("hours") as! NSArray
            
            
            for i in 0...days.count - 1 {
                let dayitem = dayItem()
                //var temp = String(i)
                dayitem.week = days[i].objectForKey("week") as! NSString
                dayitem.day = days[i].objectForKey("day") as! NSString
                dayitem.hightemp = String(days[i].objectForKey("temperatureMax") as! Int)
                dayitem.lowtemp = String(days[i].objectForKey("temperatureMin") as! Int)
                dayitem.icon = String(days[i].objectForKey("icon") as! NSString)
                self.dayArray.addObject(dayitem)
            }
            
            for j in 0...hours.count - 1 {
                let houritem = hourItem()
                houritem.Time = hours[j].objectForKey("time") as! NSString
                houritem.Summary = hours[j].objectForKey("summary") as! NSString
                houritem.Temp = String(hours[j].objectForKey("temp") as! Int)
                self.hourArray.addObject(houritem)
            }
            
            self.currentDic = current
            
            
            

            //facebook
            self.content.contentURL = NSURL(string: "https://forecast.io")
            self.content.contentTitle = "Current Weather in " + self.city + ", " + self.state
            self.content.contentDescription = self.FBsummary + ", " + self.FBtemperature
            self.content.imageURL = NSURL(string: self.FBweathericon)
            
            print(self.FBsummary + "," + self.FBtemperature + "," + self.FBweathericon)
            //FBSDKShareDialog.showFromViewController(self, withContent: slef.content, delegate: self)
            
            //self.button.shareContent = self.content
            //self.button.frame = CGRectMake(0.05 * self.view.frame.width + 250, 10, 100, 30)
            //self.mainScrollView.addSubview(self.button)
            
            
            
            
            self.FBsummary = current["summary"] as! String
            if(self.degree == "us")
            {
                self.FBtemperature = (current["temperature"]?.stringValue)! + "°F"
            }
            else
            {
                self.FBtemperature = (current["temperature"]?.stringValue)! + "°C"
            }
            //self.FBweathericon =
            switch (current["icon"] as! String) {
            case "clear-day":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/clear.png"
                break
            case "clear-night":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/clear_night.png"
                break
            case "rain":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/rain.png"
                break
            case "snow":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/snow.png"
                break
            case "sleet":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/sleet.png"
                break
            case "wind":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/wind.png"
                break
            case "fog":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/fog.png"
                break
            case "cloudy":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/cloudy.png"
                break
            case "partly-cloudy-day":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/cloud_day.png"
                break
            case "partly-cloudy-night":
                self.FBweathericon = "http://cs-server.usc.edu:45678/hw/hw8/images/cloud_night.png"
                break
            default:
                break
                
            }
            
            
            //WeatherMap
            self.lon = current["long"] as! Double
            self.lat = current["latt"] as! Double
            //self.performSegueWithIdentifier("search", sender: self)
            
            self.loadWeatherForecast()
            
        })
        task.resume()
        
        
        
    }

    func fbshare(){
        FBSDKShareDialog.showFromViewController(self, withContent: self.content, delegate: self)
    }
    
    func loadWeatherForecast(){
        
        print(APIURL)
        
        let current = currentDic
        
        //current weather
        self.iconImg.image = self.weatherImg(current["icon"] as! String) as UIImage
        self.summaryLabel.text = (current["summary"] as! String) + " in " + self.city + ", " + self.state
        if(self.degree == "us")
        {
            self.tempLabel.text = (current["temperature"]?.stringValue)! + "°F"
        }
        else
        {
            self.tempLabel.text = (current["temperature"]?.stringValue)! + "°C"
        }
        self.highlowLabel.text = "L:" + (current["lowtemp"]?.stringValue)! + "°|H:" + (current["hightemp"]?.stringValue)! + "°"
        let precipitationtemp = current["precipitation"] as! Double
        if((precipitationtemp >= 0) && (precipitationtemp < 0.002))
        {self.precipitationResult.text = "None"}
        else if( precipitationtemp >= 0.002 && precipitationtemp < 0.017)
        {self.precipitationResult.text = "Very Light"}
        else if(precipitationtemp >=  0.017&&precipitationtemp < 0.1)
        {self.precipitationResult.text = "Light"}
        else if(precipitationtemp >= 0.1 && precipitationtemp < 0.4)
        {self.precipitationResult.text = "Moderate"}
        else if(precipitationtemp >= 0.4)
        {self.precipitationResult.text = "Heavy"}
        var raintemp = current["chanceofrain"] as! Int
        raintemp = raintemp * 100
        self.rainResult.text = String(raintemp) + " %"
        
        if(self.degree == "us")
        {
            self.windResult.text = String(format: "%.2f", current["windspeed"] as! Double) + " mph"
            self.dewpointResult.text = String(Int(current["dewpoint"] as! NSNumber)) + " °F"
            
            if current["visibility"] as! Double == 0 {
                self.visibilityResult.text = "N/A"
            }else{
                self.visibilityResult.text = String(format: "%.2f", current["visibility"] as! Double) + " mi"

            }
            
        }
        else{
            self.windResult.text = String(format: "%.2f", current["windspeed"] as! Double) + " m/s"
            self.dewpointResult.text = String(Int(current["dewpoint"] as! NSNumber)) + " °C"
            
            if current["visibility"] as! Double == 0 {
                self.visibilityResult.text = "N/A"
            }else {
                self.visibilityResult.text = String(format: "%.2f", current["visibility"] as! Double) + " km"
            }
            
        }
        
        self.humidityResult.text = String((current["humidity"] as! Double) * 100) + " %"
        self.sunriseResult.text = (current["sunrise"] as! String)
        self.sunsetResult.text = (current["sunset"] as! String)
        
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("sharing results \(results)")
        if (results["postId"] != nil) {
            self.view.makeToast("Facebook Post Successful")
        } else {
            self.view.makeToast("Posted Cancelled")
        }
        
        print(results)
    }
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print(error)
    }
    func sharerDidCancel(sharer: FBSDKSharing!) {
        self.view.makeToast("Posted Cancelled")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            //let detaildayVC = segue.destinationViewController as! daysTableViewController
            let detailVC = segue.destinationViewController as! detailViewController
            
            
            detailVC.hours = self.hourArray
            detailVC.days = self.dayArray
            
            detailVC.city = self.city
            detailVC.state = self.state
            print("prepare for segue")
            
        } else if segue.identifier == "map" {
            let mapVC = segue.destinationViewController as! mapViewController
            
            mapVC.lon = self.lon
            mapVC.lat = self.lat
            print("goto map")
            print("lat" + String(self.lat) + "lon" + String(self.lon))
        }
    }
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        
    }
    
}
