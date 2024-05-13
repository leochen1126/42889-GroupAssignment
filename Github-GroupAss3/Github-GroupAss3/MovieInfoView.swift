//
//  MovieInfoView.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun on 12/5/2024.
//

import SwiftUI

struct MovieInfoView: View {
    @ObservedObject var viewModel: MovieInfoViewModel
    let movie: Movie
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .center, spacing: 20) {
                    if let omdbMovie = viewModel.omdbMovies[movie.id], let imageUrl = URL(string: omdbMovie.poster) {
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
                    Text(movie.title)
                        .foregroundColor(.white)
                        .font(.title)
                    
                    // Additional movie details from OMDB
                    if let omdbMovie = viewModel.omdbMovies[movie.id] {
                        
                        Text("\(omdbMovie.plot)")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(.horizontal)
                        
                        Text("Ratings: \(omdbMovie.imdbRating)")
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(.horizontal)
                        
                        // Movie seat count
                        Text("Seats left: \(movie.seatCount)")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitle("Movie Info", displayMode: .inline)
        .onAppear {
            viewModel.fetchOMDBDetails(for: movie)
            print("API called for movie: \(movie.title)")
        }
    }
}

struct MovieInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let movies = [
            Movie(id: "1", title: "Kingdom of the Planet of the Apes", details: "", imageUrl: "", seatCount: 30),
            Movie(id: "2", title: "Challengers", details: "", imageUrl: "", seatCount: 49),
            Movie(id: "3", title: "Civil War", details: "", imageUrl: "", seatCount: 30),
            Movie(id: "4", title: "Dune: Part Two", details: "", imageUrl: "", seatCount: 30),
        ]
        let viewModel = MovieInfoViewModel()
        
        return MovieInfoPreviewContainer(movies: movies, viewModel: viewModel)
    }
}

struct MovieInfoPreviewContainer: View {
    let movies: [Movie]
    let viewModel: MovieInfoViewModel

    // Define the grid layout
    var gridLayout: [GridItem] = Array(repeating: .init(.flexible(minimum: 200, maximum: 400)), count: 1) // Single column for horizontal scrolling

    var body: some View {
        // Set ScrollView to horizontal
        ScrollView(.horizontal, showsIndicators: true) {
            // Use LazyHGrid for horizontal grid arrangement
            LazyHGrid(rows: gridLayout, spacing: 20) {
                ForEach(movies, id: \.id) { movie in
                    MovieInfoView(viewModel: viewModel, movie: movie)
                        .padding(.top)
                        .frame(width: 350, height: 700)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.black)
        }
    }
}

struct OMDBMovie: Codable {
    let plot: String
    let imdbRating: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case plot = "Plot"
        case imdbRating
        case poster = "Poster"
    }
}
