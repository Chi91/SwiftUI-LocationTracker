//
//  LocationManager.swift
//  CoreLocationDemo
//
//  Created by admin on 25.11.22.
//

import Foundation

//zentrale Framework für zugriff auf Datenerfassung von Standorten des Gerätes
import CoreLocation
import MapKit
import UserNotifications
import AVFoundation

// zentrale klasse CLLocationManager
// property von der Klasse  u.a. delegate: CLLocationManagerDelegate(Type d Property - protocol)


// NSObject ist superklasse daher erste position, danach nur noch protokolle
class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject{
    
    //@Published bedeutet, dass diese Property beobachtet wird für @StateObject in ContentView
    @Published var lat = 0.0
    @Published var long = 0.0
    @Published var changeButton0 = false
    @Published var changeButton1 = false
    @Published var changeButton2 = false
    @Published var changeButton3 = false
    @Published var changeButton4 = false
    @Published var changeButton5 = false
    var locationClCircleRegion: [CLCircularRegion] = Array()
    
    // MKCordinateRegion ist eine Struktur;
    // Mk ist abkürzung für MapKit
   @Published var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.50616, longitude: 13.332060), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

    
    var locationManager: CLLocationManager
//    var notificationCenter = UNUserNotificationCenter.current()
    var locations = [
        Location(title: "BVG", task:"Ticket", coordinate: CLLocationCoordinate2D(latitude: 52.50616, longitude: 13.332060)),
        Location(title: "McDonalds",task:"Verklagen", coordinate: CLLocationCoordinate2D(latitude: 52.510438, longitude: 13.350950)),
        Location(title: "Arzt",task:"Rezept", coordinate: CLLocationCoordinate2D(latitude: 52.517786, longitude: 13.374111)),
        Location(title: "Apotheke",task:"Zeitung", coordinate: CLLocationCoordinate2D(latitude: 52.517494, longitude: 13.395211)),
        Location(title: "Rewe",task:"Einkaufen", coordinate: CLLocationCoordinate2D(latitude: 52.506790, longitude: 13.351811)),
        Location(title: "Kiosk",task:"Zeitung", coordinate: CLLocationCoordinate2D(latitude: 52.504435, longitude: 13.343026))
    ]
   
    
    override init(){
        locationManager = CLLocationManager()
        
        super.init()
        locationManager.delegate = self
//        notificationCenter.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
//        requestNotificationAuthorization()
        
        for element in locations {
            print("Eleent von locations")
            print(element)
            locationManager.startMonitoring(for: makeCircleRegion(location: element))
        }
//        locationManager.startMonitoring(for: makeCircleRegion(location: locations[0]))
//        locationManager.startMonitoring(for: makeCircleRegion(location: locations[1]))
//        locationManager.startMonitoring(for: makeCircleRegion(location: locations[2]))
//        locationManager.startMonitoring(for: makeCircleRegion(location: locations[3]))
//        locationManager.startMonitoring(for: makeCircleRegion(location: locations[4]))
//        locationManager.startMonitoring(for: makeCircleRegion(location: locations[5]))

        print(locationManager.monitoredRegions)

        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let lastLocation = locations.last

                guard let myLat = lastLocation?.coordinate.latitude else { return}
                guard let myLon = lastLocation?.coordinate.longitude else {return }
                checkRegion(givenLatitude: myLat, givenLongitude: myLon)
                self.lat = myLat
                self.long = myLon
    }
    
    func checkRegion(givenLatitude: Double, givenLongitude: Double){
        var counter = 0
        for i in self.locationClCircleRegion{
            if(i.contains(CLLocationCoordinate2D(latitude: givenLatitude, longitude: givenLongitude))){
                changeButtonBolValue(number: counter)
                AudioServicesPlaySystemSound(1002)
//                print("Region \(counter) wurde betreten!!!!")
//                print("changeButton 0 hat den Wert \(changeButton0)!!!")
//                print("changeButton 1 hat den Wert \(changeButton1)!!!")
//                print("changeButton 2 hat den Wert \(changeButton2)!!!")
//                print("changeButton 3 hat den Wert \(changeButton3)!!!")
//                print("changeButton 4 hat den Wert \(changeButton4)!!!")
//                print("changeButton 5 hat den Wert \(changeButton5)!!!")
            }
            counter += 1
        }
    }
    
    func changeButtonBolValue(number:Int){
        switch number{
        case 0: changeButton0 = true
        case 1: changeButton1 = true
        case 2: changeButton2 = true
        case 3: changeButton3 = true
        case 4: changeButton4 = true
        case 5: changeButton5 = true
        default: break
        }
    }
    // Methode zur Erzeugung von CircleRegion für Location (idF point of interest)
    func makeCircleRegion(location: Location)->CLCircularRegion{
//        print("makeRegion")
//        print(location.coordinate)
        let region = CLCircularRegion(center: location.coordinate, radius: 50, identifier: UUID().uuidString)
//        print(type(of: region))
        region.notifyOnEntry = true
        locationClCircleRegion.append(region)
        return region
    }
    
//    func requestNotificationAuthorization(){
////        let nullLocation = Location(title: "No Title", task: "no Task", coordinate: CLLocationCoordinate2D(latitude: 50.0, longitude: 50.0))
//        let options: UNAuthorizationOptions = [.sound, .alert]
//        notificationCenter.requestAuthorization(options: options){
//            [weak self] result, _ in
//            print("Notification Auth Request result: \(result)")
//            if result {
////                self?.registerNotification(location: self?.locations[0] ?? nullLocation)
//                self?.registerNotification(location: self!.locations[0])
//                self?.registerNotification(location: self!.locations[1])
//                self?.registerNotification(location: self!.locations[2])
//                self?.registerNotification(location: self!.locations[3])
//                self?.registerNotification(location: self!.locations[4])
//                self?.registerNotification(location: self!.locations[5])
//            }
//        }
//    }
//
//    func registerNotification(location: Location){
//        let notificationContent = UNMutableNotificationContent()
//        notificationContent.title = location.title
//        notificationContent.body = location.task
//        notificationContent.sound = .default
//        let specificCLCircleRegion: CLCircularRegion = makeCircleRegion(location: location)
//        let trigger = UNLocationNotificationTrigger(region: specificCLCircleRegion, repeats:false)
//        locationClCircleRegion.append(specificCLCircleRegion)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
//
//        notificationCenter.add(request){error in
//            if error != nil {
//                print("Error: \(String(describing: error))")
//            }
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        AudioServicesPlaySystemSound(1002)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
////        for i in 0..<locations.count {
////            if(locations[i].id.uuidString == region.identifier) {
////
////                let notificationContent = UNMutableNotificationContent()
////                notificationContent.title = locations[i].title
////                notificationContent.body = locations[i].task
////                notificationContent.sound = .default
////                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
////                let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
////                UNUserNotificationCenter.current().add(request)
////
////            }
////        }
//        print("didenterregion")
//        print(region)
//    }
}

//extension LocationManager: UNUserNotificationCenterDelegate{
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("Received Notification")
//        completionHandler()
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("Received Notification in Foreground")
////        AudioServicesPlaySystemSound(1026)
//        completionHandler([.alert,.sound])
//    }
//}





