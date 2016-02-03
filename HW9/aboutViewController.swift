//
//  aboutViewController.swift
//  WeatherForecast
//
//  Created by Xingye on 12/7/15.
//  Copyright © 2015 Xingye. All rights reserved.
//

import UIKit

class aboutViewController:UIViewController {
    
    @IBOutlet weak var myImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initAll(){
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        navigationBar.frame = CGRectMake(0, 0, w, 64)
        //navigationBar.backgroundColor = UIColor.whiteColor()
        //navigationBar.alpha = 0.8
        
        let bgimg = UIImageView(image: UIImage(named: "sky.jpg"))
        bgimg.frame = CGRectMake(0, 0, w, h)
        bgimg.alpha = 0.8
        //self.view.addSubview(bgimg)
        
        myImg.frame = CGRectMake(0.25*w, 0.2*h, 220, 220)
        self.view.addSubview(myImg)
        
        nameLabel.frame = CGRectMake(0.25*w, 0.5*h, 0.5*w, 50)
        nameLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(nameLabel)
        
        idLabel.frame = CGRectMake(0.25*w, 0.55*h, 0.5*w, 50)
        idLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(idLabel)
        
    }
}