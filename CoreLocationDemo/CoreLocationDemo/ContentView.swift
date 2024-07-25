//
//  ContentView.swift
//  CoreLocationDemo
//
//  Created by admin on 25.11.22.
//

import SwiftUI
import MapKit
import AVFoundation

// Definiere einen Standort
struct Location: Identifiable{
    let id = UUID()
    let title: String
    let task: String
    let coordinate: CLLocationCoordinate2D
}

struct ToastModifier: ViewModifier{
    @Binding var isShowing: Bool
    let duration: TimeInterval
    let text: String
    
    func body(content: Content) -> some View {
        VStack{
            
            if isShowing{
                VStack{
                    HStack{
                        Image(systemName: "heart.fill")
                        Text(text)
                            .font(.footnote)
//                        Spacer()
                    }
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                }
                .padding()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                        withAnimation{
                            isShowing = false
                        }
                    }
                }
            }
            
            content
          
       }
    }
}
extension View{
    func toast(isShowing: Binding<Bool>, duration: TimeInterval = 5, text: String) ->some View {
        modifier(ToastModifier(isShowing: isShowing, duration: duration,text: text))
    }
}
struct ContentView: View {
    
    @StateObject var locManager = LocationManager()
    @State var didTap0 = false
    @State var didTap1 = false
    @State var didTap2 = false
    @State var didTap3 = false
    @State var didTap4 = false
    @State var didTap5 = false
    @State var changeButton0 = false
    @State var changeButton1 = false
    @State var changeButton2 = false
    @State var changeButton3 = false
    @State var changeButton4 = false
    @State var changeButton5 = false
    
    
//    @State var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.50616, longitude: 13.332060), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        ZStack {
            
            //            Text("Da bin ich: [LAT: \(locManager.lat)] [LON]: \(locManager.long)!")
            
            //            Map(coordinateRegion: $coordinateRegion, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locations){
            //                location in MapMarker(coordinate: location.coordinate)
            //            }
            //        }
            
            Map(coordinateRegion: $locManager.coordinateRegion,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: locManager.locations){
                location in MapAnnotation(coordinate: location.coordinate) {
                    Circle()
                        .stroke(.red, lineWidth: 3)
                        .frame(width: 20, height: 20)
                }
            }.ignoresSafeArea()
            
            VStack(){
                Spacer()
                HStack{
                    if(didTap0 == false){
                        Button(action:{ changeButton0DidTap()}){
                            Text("BVG,Ticket")
                                .bold()
                                .font(.system(size: 15))
                                .frame(width: 75, height: 75)
                            //                                .onReceive(locManager.$changeButton0) { changeButton0 in
                            //                                    self.changeButton0 = changeButton0
                            //                                }
                            //                                .background(changeButton0 ? .yellow : .red)
                                .background(locManager.changeButton0 ? .yellow : .red)
                                .foregroundColor(.black)
                                .clipShape(Rectangle()).cornerRadius(10)
                               
                        }.toast(isShowing: $locManager.changeButton0, text: "BVG,Ticket")
                    }
                    else{
                        Button(action:{}){
                            Text("BVG,Ticket")
                                .bold()
                                .font(.system(size: 15))
                                .frame(width: 75, height: 75)
                                .background(.green)
                                .foregroundColor(.black)
                                .clipShape(Rectangle()).cornerRadius(10)
                        }
                    }
                    if(didTap1 == false){
                        Button(action:{ changeButton1DidTap()}){
                            Text("McDonald,Verklagen")
                                .bold()
                                .font(.system(size: 15))
                                .frame(width: 75, height: 75)
                                .background(locManager.changeButton1 ? .yellow : .red)
                                .foregroundColor(.black)
                                .clipShape(Rectangle()).cornerRadius(10)
                        }.toast(isShowing: $locManager.changeButton1, text: "McDonald,Verklagen")
                    }
                    else{
                        Button(action:{}){
                            Text("McDonald,Verklagen")
                                .bold()
                                .font(.system(size: 15))
                                .frame(width: 75, height: 75)
                                .background(.green)
                                .foregroundColor(.black)
                                .clipShape(Rectangle()).cornerRadius(10)
                        }
                    }
                    if(didTap2 == false){
                        Button(action:{ changeButton2DidTap()}){
                            Text("Arzt,Rezept")
                                .bold()
                                .font(.system(size: 15))
                                .frame(width: 75, height: 75)
                                .background(locManager.changeButton2 ? .yellow : .red)
                                .foregroundColor(.black)
                                .clipShape(Rectangle()).cornerRadius(10)
                        }.toast(isShowing: $locManager.changeButton2, text: "Arzt,Rezept")
                    }
                    else{
                        Button(action:{}){
                            Text("Arzt,Rezept")
                                .bold()
                                .font(.system(size: 15))
                                .frame(width: 75, height: 75)
                                .background(.green)
                                .foregroundColor(.black)
                                .clipShape(Rectangle()).cornerRadius(10)
                        }
                    }
                }
                Spacer()
                VStack{
                    HStack{
                        if(didTap3 == false){
                            Button(action:{ changeButton3DidTap()}){
                                Text("Rewe,Einkaufen")
                                    .bold()
                                    .font(.system(size: 15))
                                    .frame(width: 75, height: 75)
                                    .background(locManager.changeButton3 ? .yellow : .red)
                                    .foregroundColor(.black)
                                    .clipShape(Rectangle()).cornerRadius(10)
                            }.toast(isShowing: $locManager.changeButton3, text: "Rewe,Einkaufen")
                        }
                        else{
                            Button(action:{}){
                                Text("Rewe,Einkaufen")
                                    .bold()
                                    .font(.system(size: 15))
                                    .frame(width: 75, height: 75)
                                    .background(.green)
                                    .foregroundColor(.black)
                                    .clipShape(Rectangle()).cornerRadius(10)
                            }
                        }
                        if(didTap4 == false){
                            Button(action:{ changeButton4DidTap()}){
                                Text("Kiosk,Zeitung")
                                    .bold()
                                    .font(.system(size: 15))
                                    .frame(width: 75, height: 75)
                                    .background(locManager.changeButton4 ? .yellow : .red)
                                    .foregroundColor(.black)
                                    .clipShape(Rectangle()).cornerRadius(10)
                            }.toast(isShowing: $locManager.changeButton4, text: "Kiosk,Zeitung")
                        }
                        else{
                            Button(action:{}){
                                Text("Kiosk,Zeitung")
                                    .bold()
                                    .font(.system(size: 15))
                                    .frame(width: 75, height: 75)
                                    .background(.green)
                                    .foregroundColor(.black)
                                    .clipShape(Rectangle()).cornerRadius(10)
                            }
                        }
                        if(didTap5 == false){
                            Button(action:{ changeButton5DidTap()}){
                                Text("Apotheke,Kalender")
                                    .bold()
                                    .font(.system(size: 15))
                                    .frame(width: 75, height: 75)
                                    .background(locManager.changeButton5 ? .yellow : .red)
                                    .foregroundColor(.black)
                                    .clipShape(Rectangle()).cornerRadius(10)
                            }.toast(isShowing: $locManager.changeButton5, text: "Apotheke,Kalender")
                        }
                        else{
                            Button(action:{}){
                                Text("Apotheke,Kalender")
                                    .bold()
                                    .font(.system(size: 15))
                                    .frame(width: 75, height: 75)
                                    .background(.green)
                                    .foregroundColor(.black)
                                    .clipShape(Rectangle()).cornerRadius(10)
                            }
                        }
                    }
                   
                }
          
                Spacer()
                
            }
        }
    }
        
        func changeButton0DidTap(){
            if(locManager.changeButton0){
                didTap0 = true
            }
        }
        func changeButton1DidTap(){
            if(locManager.changeButton1){
                didTap1 = true
            }
        }
        func changeButton2DidTap(){
            if(locManager.changeButton2){
                didTap2 = true
            }
            
        }
        func changeButton3DidTap(){
            if(locManager.changeButton3){
                didTap3 = true
            }
        }
        func changeButton4DidTap(){
            if(locManager.changeButton4){
                didTap4 = true
            }
            
        }
        func changeButton5DidTap(){
            if(locManager.changeButton5){
                didTap5 = true
            }
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
