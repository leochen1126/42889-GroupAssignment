//
//  MovieInfoView.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun on 12/5/2024.
//

import SwiftUI

struct MovieInfoView: View {
    @ObservedObject var viewModel: MovieInfoViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .center, spacing: 20) {
                    if let omdbMovie = viewModel.omdbMovie, let imageUrl = URL(string: omdbMovie.poster) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(8)
                        } placeholder: {
                            Rectangle()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(8)
                        }
                        .frame(width: 400, height: 300)
                        .padding(.vertical)
                    }
                    
                    // Movie title
                    Text(viewModel.movie.title)
                        .foregroundColor(.white)
                        .font(.title)
                    
                    // Additional movie details from OMDB
                    if let omdbMovie = viewModel.omdbMovie {
                        Text(omdbMovie.plot)
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(.horizontal)
                        
                        Text("Ratings: \(omdbMovie.imdbRating)")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(.horizontal)
                        
                        // Movie seat count
                        Text("Seats left: \(viewModel.movie.seatCount)")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitle("Movie Info", displayMode: .inline)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            viewModel.fetchOMDBDetails()
            print("API called for movie: \(viewModel.movie.title)")
        }
    }
}

struct MovieInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(id: "1", title: "Kingdom of the Planet of the Apes", details: "", imageUrl: "", seatCount: 50)
        let viewModel = MovieInfoViewModel(movie: movie)
        
        return MovieInfoView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}


