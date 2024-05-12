//
//  AfterBookViewModel.swift
//  Github-GroupAss3
//
//  Created by Gandi on 12/5/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class AfterBookViewModel: ObservableObject {
    private var db = Firestore.firestore()
    public var movieTitle: String

    init(movieTitle: String) {
        self.movieTitle = movieTitle
    }

    func uploadBookingDetails(firstName: String, lastName: String, email: String, movieTitle: String) {
        // Upload booking details to database
        let bookingDetails = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "movieTitle": movieTitle,
        ]

        db.collection("movie_book").addDocument(data: bookingDetails) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added")
            }
        }
    }
}
