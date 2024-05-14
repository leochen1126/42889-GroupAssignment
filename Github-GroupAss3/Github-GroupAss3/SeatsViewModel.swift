//
//  SeatsViewModel.swift
//  Github-GroupAss3
//
//  Created by Anna Huang on 12/5/2024.
//

import Foundation

struct Seat: Identifiable, Equatable {
    var id: String { "\(row)\(number)" }
    let row: Character
    let number: Int
    var isOccupied: Bool = false
    var isSelected: Bool = false
}

class SeatsViewModel: ObservableObject {
    @Published var seats: [Seat] = []
    var selectedSeatsCount: Int {
        seats.filter { $0.isSelected }.count
    }

    init() {
        self.seats = (65...69).flatMap { row -> [Seat] in
            (1...10).map { number -> Seat in
                Seat(row: Character(UnicodeScalar(row)!), number: number, isOccupied: false, isSelected: false)
            }
        }
    }

    func selectSeat(_ seat: Seat) {
        if let index = seats.firstIndex(where: { $0.id == seat.id }) {
            if !seats[index].isOccupied {
                if seats[index].isSelected || selectedSeatsCount < 6 {
                    seats[index].isSelected.toggle()
                }
            }
        }
    }
}
