//
//  MovieInfoViewModel.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun on 12/5/2024.
//

import Foundation

struct OMDBMovie: Codable {
    let plot: String
    let imdbRating: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case plot = "Plot"
        case imdbRating = "imdbRating"
        case poster = "Poster"
    }
}

class MovieInfoViewModel: ObservableObject {
    @Published var movie: Movie
    @Published var omdbMovie: OMDBMovie?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchOMDBDetails() {
        guard let encodedTitle = movie.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.omdbapi.com/?t=\(encodedTitle)&apikey=6f79e75f") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(OMDBMovie.self, from: data)
                DispatchQueue.main.async {
                    self.omdbMovie = decodedResponse
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
}

