//
//  BookViewModel.swift
//  Github-GroupAss3
//
//  Created by Gandi on 12/5/2024.
//

import Foundation
class BookViewModel: ObservableObject {
    @Published var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}
