//
//  ManageMovieEditViewModel.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun 12/5/2024.
//

import Foundation
import FirebaseFirestore

class ManageMovieEditViewModel: ObservableObject {
    @Published var title: String
    @Published var details: String
    @Published var imageUrl: String
    @Published var seatCount: Int
    
    @Published var isTitleValid = true
    @Published var isDetailsValid = true
    @Published var isImageUrlValid = true
    @Published var isSeatCountValid = true
    
    @Published var showAlert = false
    @Published var updateSuccessful = false
    
    private var db = Firestore.firestore()
    private var movieId: String
    
    var onSuccessfulUpdate: (() -> Void)?
    
    init(movie: Movie) {
        self.title = movie.title
        self.details = movie.details
        self.imageUrl = movie.imageUrl
        self.seatCount = movie.seatCount
        self.movieId = movie.id
    }
    
    func isValidTitle() -> Bool {
        return !title.isEmpty
    }
    
    func isValidDetails() -> Bool {
        return !details.isEmpty
    }
    
    func isValidImageUrl() -> Bool {
        return !imageUrl.isEmpty
    }
    
    func isValidSeatCount() -> Bool {
        return seatCount > 0
    }
    
    func isFormValid() -> Bool {
        return isValidTitle() && isValidDetails() && isValidImageUrl() && isValidSeatCount()
    }
    
    func update() {
        if isFormValid() {
            let movieData: [String: Any] = [
                "title": title,
                "details": details,
                "imageUrl": imageUrl,
                "seatCount": seatCount
            ]
            
            db.collection("movie_master").document(movieId).updateData(movieData) { error in
                if let error = error {
                    print("Error updating info: \(error)")
                    self.showAlert = true
                    self.updateSuccessful = false
                } else {
                    print("Movie info successfully updated")
                    self.showAlert = true
                    self.updateSuccessful = true
                    DispatchQueue.main.async {
                        self.onSuccessfulUpdate?()
                    }
                }
            }
        } else {
            print("Invalid user input")
            self.showAlert = true
            self.updateSuccessful = false
        }
    }
}

