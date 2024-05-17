//
//  ManageViewModel.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun 12/5/2024.
//

import Foundation
import FirebaseFirestore

class ManageViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private var db = Firestore.firestore()
    
    func fetchMovies() {
        db.collection("movie_master").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting info: \(error)")
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
