//
//  FBViewController.swift
//  WeatherForecast
//
//  Created by Xingye on 12/9/15.
//  Copyright © 2015 Xingye. All rights reserved.
//

import UIKit

import FBSDKShareKit

class FBViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create FB
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "https://www.facebook.com/FacebookDevelopers")
        content.contentTitle = "Facebook"
        content.contentDescription = "Home page of Facebook"
        content.imageURL = NSURL(string: "http://cs-server.usc.edu:45678/hw/hw8/images/fb_icon.png")
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 50, 100, 25)
        self.view.addSubview(button)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
