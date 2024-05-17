//
//  SeatsViewModel.swift
//  Github-GroupAss3
//
//  Created by Anna Huang on 12/5/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct Seat: Identifiable, Equatable {
    let row: Character
    let number: Int
    var isOccupied: Bool = false
    var isSelected: Bool = false
    var id: String { "\(row)\(number)" }
}

class SeatsViewModel: ObservableObject {
    @Published var seats = [Seat]()
    private var db = Firestore.firestore()
    private var movieTitle: String
    
    init(movieTitle: String) {
        self.movieTitle = movieTitle
        setupSeats()
        fetchSeats()
        self.seats = (65...69).flatMap { row -> [Seat] in
            (1...10).map { number -> Seat in
                Seat(row: Character(UnicodeScalar(row)!), number: number, isOccupied: false, isSelected: false)
            }
        }
    }
    
    private func setupSeats() {
            for row in ["A", "B", "C", "D", "E"] {
                for number in 1...10 {
                    let seat = Seat(row: Character(row), number: number, isOccupied: false, isSelected: false)
                    seats.append(seat)
                }
            }
        }
    
    func fetchSeats() {
        db.collection("movie_book").document(movieTitle).collection("seats").addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                for doc in documents {
                    let data = doc.data()
                    let row = data["row"] as? String ?? "A"
                    let number = data["number"] as? Int ?? 1
                    let isOccupied = data["isOccupied"] as? Bool ?? false
                    if let index = self.seats.firstIndex(where: { $0.row == Character(row) && $0.number == number }) {
                        self.seats[index].isOccupied = isOccupied
                    }
                }
            }
        }
    
    func selectSeat(_ seat: Seat) {
        guard let index = seats.firstIndex(where: { $0.id == seat.id }) else { return }
   //     seats[index].isOccupied.toggle()
   //     updateSeatAvailability(seat: seats[index], isOccupied: seats[index].isOccupied)
       
        if seats[index].isSelected || (selectedSeatsCount < 6 && !seats[index].isSelected) {
                seats[index].isSelected.toggle()
            }
        }
    
    func confirmBooking() {
        for seat in seats.filter({ $0.isSelected }) {
            updateSeatAvailability(seat: seat, isOccupied: true)
        }
    }
    
    private func updateSeatAvailability(seat: Seat, isOccupied: Bool) {
        guard let index = seats.firstIndex(where: { $0.id == seat.id }) else { return }
        seats[index].isOccupied = isOccupied
        let seatData: [String: Any] = [
                    "row": String(seat.row),
                    "number": seat.number,
                    "isOccupied": isOccupied
        ]
        
        db.collection("movie_book").document(movieTitle).collection("seats").document(seat.id).setData(seatData) { err in
            if let err = err {
                print("Error updating seat: \(err)")
            } else {
                print("Seat successfully updated")
            }
        }
    }
    
    var selectedSeatsCount: Int {
        seats.filter { $0.isSelected }.count
    }
}
