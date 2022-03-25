//
//  ContentView.swift
//  MapTripper
//
//  Created by CD on 3/23/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true )
            .ignoresSafeArea()
            .accentColor(Color("Royal Blue"))
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        
        MapView()
        ZStack {
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 25)
                
            }
        }
    }
}
