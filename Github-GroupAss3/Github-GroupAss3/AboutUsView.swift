//
//  AboutUsView.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 11/5/2024.
//

import SwiftUI
import MapKit
struct AboutUsView: View {
    let utsBuilding2Coordinate = CLLocationCoordinate2D(latitude: -33.8836, longitude: 151.1982)
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                MapView(coordinate: utsBuilding2Coordinate)
                    .frame(height: 350) // Adjust the map height as needed
                    .padding()
                    .clipShape(Rectangle())
                
                Text("CTS")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                    .bold()
                
                Text("15 Broadway, Ultimo, Sydney, NSW 2007")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
                Spacer()
            }
        }
    }
}

struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "UTS Building 2"
        uiView.addAnnotation(annotation)

        // Set the region to focus on UTS Building 2
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

#Preview {
    AboutUsView()
}
