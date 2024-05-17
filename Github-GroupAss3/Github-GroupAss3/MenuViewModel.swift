//
//  MenuViewModel.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 12/5/2024.
//  Edited by Gandi Lu on 12/5/2024.
//
import Foundation
import FirebaseCore
import FirebaseFirestore

class Movie: Identifiable {
    let id: String
    let title: String
    let details: String
    let imageUrl: String
    let seatCount: Int
    
    init(id: String, title: String, details: String, imageUrl: String, seatCount: Int) {
        self.id = id
        self.title = title
        self.details = details
        self.imageUrl = imageUrl
        self.seatCount = seatCount
    }
}

class MenuViewModel: ObservableObject {
    @Published var username: String = "Login"
    @Published var movies: [Movie] = []
    private var db = Firestore.firestore()
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies() {
        db.collection("movie_master").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let title = data["title"] as? String,
                       let details = data["details"] as? String,
                       let imageUrl = data["imageUrl"] as? String,
                       let seatCount = data["seatCount"] as? Int {
                        let movie = Movie(id: document.documentID, title: title, details: details, imageUrl: imageUrl, seatCount: seatCount)
                        self.movies.append(movie)
                    }
                }
            }
        }
    }
}
