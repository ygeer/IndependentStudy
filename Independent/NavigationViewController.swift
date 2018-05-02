//
//  NavigationViewController.swift
//  Independent
//
//  Created by Yoni Geer on 4/11/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Parse

class NavigationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    var speedarr=[Double]()
    @IBOutlet var topspeed: UILabel!
    @IBOutlet var speed: UILabel!
    @IBOutlet var map: MKMapView!
    var locationManager=CLLocationManager()
    var toptest: Double=0
    var bool=0
    let user=PFUser.current()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        

    }
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        
        
        if let currentusertopspeed=user!["TopSpeed"] as? Double{
            if bool==0{
                toptest=currentusertopspeed
                topspeed.text=String(currentusertopspeed)
                user!["TopSpeed"]=Int(toptest)
                user?.saveInBackground()
                bool=1
                print("once")
            }
        }
            if toptest<userLocation.speed{
                toptest=userLocation.speed
                topspeed.text=String(toptest)
                user!["TopSpeed"]=Int(toptest)
                user?.saveInBackground()
            }
        
        
        
        
        
        let latitude=userLocation.coordinate.latitude
        let longitude=userLocation.coordinate.longitude
         
        let latdelta:CLLocationDegrees = 0.05
        let londelta:CLLocationDegrees = 0.05
         
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latdelta, longitudeDelta: londelta)
         
         
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
         
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
         
        self.map.setRegion(region, animated: true)
        // print(locations[0])
        
        self.speed.text=String(userLocation.speed)
        speedarr.append(Double(userLocation.speed))
       
        
        //print(userLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
