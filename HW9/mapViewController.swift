//
//  mapViewController.swift
//  WeatherForecast
//
//  Created by Xingye on 12/9/15.
//  Copyright © 2015 Xingye. All rights reserved.
//
import UIKit
import GoogleMaps


class mapViewController:UIViewController,AWFWeatherMapDelegate {
    
    
    var weatherMap : AWFWeatherMap = AWFWeatherMap.init(mapType: AWFWeatherMapType.Google)
    var lat:Double = 0
    var lon:Double = 0
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        //self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        */
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        
        
        print("lat" + String(self.lat) + "lon" + String(self.lon))
        
        let latitude = CLLocationDegrees.init(floatLiteral: lat)
        let longitude = CLLocationDegrees.init(floatLiteral: lon)
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        
        weatherMap.weatherMapView.frame = self.view.bounds
        weatherMap.setMapCenterCoordinate(coordinate, zoomLevel: 10, animated: true)
        weatherMap.addLayerType(AWFLayerType.RadarSatellite)
        
        self.view.addSubview(weatherMap.weatherMapView)
        
        navigationBar.frame = CGRectMake(0, 0, w, 64)
        self.view.addSubview(navigationBar)
        //weatherMap.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
