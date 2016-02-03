//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Xingye on 12/6/15.
//  Copyright © 2015 Xingye. All rights reserved.
//

import UIKit

import FBSDKShareKit

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var streetInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var degreeSegment: UISegmentedControl!
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet weak var forecastioButton: UIButton!
    @IBOutlet weak var powerbyLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func searchButton(sender: UIButton) {
        street = streetInput.text!
        city = cityInput.text!
        state = statesShort[statePicker.selectedRowInComponent(0)]
        if(degreeSegment.selectedSegmentIndex == 0)
        {degree = "us"}
        else {degree = "si"}
        
        print(street+","+city+","+state+","+degree)
        
        
        if(validate()){
        
            self.APIURL = "http://homework10-env.elasticbeanstalk.com/index.php?street=" + street + "&city=" + city + "&states=" + state + "&temp=" + degree
            
            //loadWeather()
            
            self.performSegueWithIdentifier("search", sender: self)
            
        }else{
            print("validate not success!")
            return
        }

        
    }
    @IBAction func clearButton(sender: UIButton) {
        
        streetInput.text = ""
        cityInput.text = ""
        statePicker.selectRow(0, inComponent: 0, animated: true)
        degreeSegment.selectedSegmentIndex = 0
        errorLabel.text = ""
        
    }
    @IBAction func forcastio(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://forecast.io")!)
    }
    
    var street = ""
    var city = ""
    var state = ""
    var degree = ""
    
    var APIURL = "http://homework10-env.elasticbeanstalk.com/index.php?street=325+w+adams+blvd&city=Los+Angeles&states=CA&temp=us"
    //var APIURL = "http://homework10-env.elasticbeanstalk.com/index.php?street=" + street + "&city=" + city + "&states=" + state + "&temp=" + degree
    //var APIURL = ""
    
    var currentDic:NSDictionary = NSDictionary()
    var dayArray:NSMutableArray = []
    var hourArray:NSMutableArray = []
    
    let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
    var FBsummary = ""
    var FBweathericon = ""
    var FBtemperature = ""
    
    //weatherMap
    var lat:Double = 0
    var lon:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initAll()
        
        //loadWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initAll(){
        
        //errorlabel
        errorLabel.text = ""
        
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        let bgimg = UIImageView(image: UIImage(named: "sky2.jpg"))
        bgimg.frame = CGRectMake(0, 0, w, h)
        self.view.addSubview(bgimg)
    
        //black bgview
        let bgview = UIView()
        bgview.frame = CGRectMake(0.05*w, 0.1*h, 0.9*w, 0.85*h)
        bgview.backgroundColor = UIColor.blackColor()
        bgview.alpha = 0.1
        self.view.addSubview(bgview)
        
        
        
        //let titleLabel = UILabel()
        titleLabel.text = "Forecast Search"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont(name: "Times", size: 35)
        titleLabel.frame = CGRectMake(0, 0.15*h, w, 40)
        titleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(titleLabel)
        
        //street
        streetLabel.text = "Street"
        streetLabel.textAlignment = NSTextAlignment.Left
        streetLabel.font = UIFont(name: "Times", size: 25)
        streetLabel.frame = CGRectMake(0.1*w, 0.25*h, 0.2*w, 35)
        self.view.addSubview(streetLabel)
        
        streetInput.frame = CGRectMake(0.3*w, 0.25*h, 0.6*w, 35)
        streetInput.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.9)
        self.view.addSubview(streetInput)
        
        //city
        cityLabel.text = "City"
        cityLabel.textAlignment = NSTextAlignment.Left
        cityLabel.font = UIFont(name: "Times", size: 25)
        cityLabel.frame = CGRectMake(0.1*w, 0.35*h, 0.2*w, 35)
        self.view.addSubview(cityLabel)
        
        cityInput.frame = CGRectMake(0.3*w, 0.35*h, 0.6*w, 35)
        cityInput.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(cityInput)

        //state
        stateLabel.text = "State"
        stateLabel.textAlignment = NSTextAlignment.Left
        stateLabel.font = UIFont(name: "Times", size: 25)
        stateLabel.frame = CGRectMake(0.1*w, 0.45*h, 0.2*w, 35)
        self.view.addSubview(stateLabel)
        
        statePicker.frame = CGRectMake(0.3*w, 0.45*h, 0.6*w, 40)
        statePicker.clipsToBounds = true
        statePicker.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(statePicker)
        
        //degree
        degreeLabel.text = "Degree"
        degreeLabel.textAlignment = NSTextAlignment.Left
        degreeLabel.font = UIFont(name: "Times", size: 25)
        degreeLabel.frame = CGRectMake(0.1*w, 0.55*h, 0.2*w, 35)
        self.view.addSubview(degreeLabel)
    
        degreeSegment.selectedSegmentIndex = 0
        degreeSegment.frame = CGRectMake(0.3*w, 0.55*h, 0.6*w, 35)
        degreeSegment.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(degreeSegment)
                
        searchButton.titleLabel?.text = "SEARCH"
        searchButton.frame = CGRectMake(0.1*w, 0.65*h+10, 80, 35)
        searchButton.backgroundColor = UIColor.whiteColor()
        searchButton.titleLabel?.textAlignment = NSTextAlignment.Center
        searchButton.tintColor = UIColor.blackColor()
        self.view.addSubview(searchButton)
        
        clearButton.titleLabel?.text = "CLEAR"
        clearButton.frame = CGRectMake(0.3*w+10, 0.65*h+10, 60, 35)
        clearButton.titleLabel?.textAlignment = NSTextAlignment.Center
        clearButton.tintColor = UIColor.blackColor()
        clearButton.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(clearButton)
        
        
        
        errorLabel.frame = CGRectMake(0, 0.73*h, w, 30)
        errorLabel.textAlignment = NSTextAlignment.Center
        errorLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(errorLabel)
        
        aboutButton.frame = CGRectMake(0.1*w, 0.8*h, 65, 32)
        aboutButton.backgroundColor = UIColor(red: 255, green: 200, blue: 255, alpha: 0.7)
        self.view.addSubview(aboutButton)
        
        powerbyLabel.frame = CGRectMake(0.1*w, 0.8*h, 0.8*w, 32)
        powerbyLabel.textAlignment = NSTextAlignment.Right
        powerbyLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(powerbyLabel)
        
        forecastioButton.frame = CGRectMake(0.6*w, 0.85*h, 0.3*w, 0.1125*w)
        forecastioButton.titleLabel?.text = ""
        //forecastioButton.backgroundColor = UIColor(patternImage: UIImage(named: "forecastio.png")!)
        //forecastioButton.imageView?.image = UIImage(named: "forecastio.png")
        self.view.addSubview(forecastioButton)
    }
    
    func validate() -> Bool {
        let streetIn = streetInput.text
        let cityIn = cityInput.text
        let stateIn = statesShort[statePicker.selectedRowInComponent(0)]
        
        if(streetIn == ""){
            errorLabel.textColor = UIColor.redColor()
            errorLabel.text = "Please enter a street address"
            return false
        } else if(cityIn == ""){
            errorLabel.textColor = UIColor.redColor()
            errorLabel.text = "Please enter a city"
            return false
        } else if(stateIn == "Select"){
            errorLabel.textColor = UIColor.redColor()
            errorLabel.text = "Please select your state"
            return false
        } else {
            errorLabel.text = ""
            
        }
        return true
        
    }
    
    let citys = ["北京", "上海", "广州"]
    
    let statesShort = ["Select","AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesShort.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statesShort[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        state = statesShort[row]
        //cityInput.text = statesShort[row]
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
            
            
            print(self.dayArray)
            print(self.hourArray)
            
            
            //facebook
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
        })
        task.resume()
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "search" {
            let goto = segue.destinationViewController as! ResultActivityViewController
            /*
            goto.FBsummary = self.FBsummary
            goto.FBtemperature = self.FBtemperature
            goto.FBweathericon = self.FBweathericon
            */
            goto.city = self.city
            goto.street = self.street
            goto.state = self.state
            goto.degree = self.degree
            /*
            goto.currentDic = self.currentDic
            goto.dayArray = self.dayArray
            goto.hourArray = self.hourArray

            goto.lon = self.lon
            goto.lat = self.lat
            */
            goto.APIURL = self.APIURL
            
            goto.loadWeather()
            
            print("go to result activity")
//            print(self.FBsummary + "," + self.FBtemperature + "," + self.FBweathericon)
//            print("current")
//            print(currentDic)
            
        }
    }

    

}

