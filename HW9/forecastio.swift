//
//  forecastio.swift
//  WeatherForecast
//
//  Created by Xingye on 12/7/15.
//  Copyright © 2015 Xingye. All rights reserved.
//

import UIKit

class forecastio: UIViewController,UIWebViewDelegate,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadurl(url: String, web:UIWebView ){
        let aurl = NSURL(string: ("http://forecast.io"))
        let urlrq = NSURLRequest(URL: aurl!)
        web.loadRequest(urlrq)
        
    }
    
    //载入动画
    func webViewDidStartLoad(webView: UIWebView) {
        //indicator1.startAnimating()
        
        //左上角的小齿轮
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    //载入结束
    func webViewDidFinishLoad(webView: UIWebView) {
        //网页中间小齿轮
        //indicator1.stopAnimating()
        
        //左上角的小齿轮
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //输入的网址请求
        //loadurl(textfield1.text!, web: webview1)
        //输入结束,键盘消失
        textField.resignFirstResponder()
        
        return true
    }

}
