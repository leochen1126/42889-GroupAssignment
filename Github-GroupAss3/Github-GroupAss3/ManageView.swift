//
//  ManageView.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun 12/5/2024.
//

import SwiftUI

struct ManageView: View {
    @ObservedObject var viewModel = ManageViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 28/255, green: 28/255, blue: 38/255).edgesIgnoringSafeArea(.all)
                VStack {
                    manageHeader
                    movieListView
                    Spacer()
                }
                .padding()
                .background(Color(red: 38/255, green: 33/255, blue: 52/255).opacity(0.8))
                .cornerRadius(16)
                .padding()
            }
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
    
    var manageHeader: some View {
        Text("Manage Movies")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
    }
    
    var movieListView: some View {
        List {
            ForEach(viewModel.movies) { movie in
                NavigationLink(destination: ManageMovieEditView(movie: movie)) {
                    HStack {
                        Text(movie.title)
                            .foregroundColor(.white)
                        Spacer()
                        Text("Seats: \(movie.seatCount)")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color(red: 38/255, green: 33/255, blue: 52/255).opacity(0.8))
                    .cornerRadius(8)
                }
                .listRowBackground(Color.clear)
            }
        }
        .background(Color.black)
        .scrollContentBackground(.hidden)
    }
}

struct ManageView_Previews: PreviewProvider {
    static var previews: some View {
        ManageView()
    }
}
