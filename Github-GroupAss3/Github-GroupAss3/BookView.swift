//
//  BookView.swift
//  Github-GroupAss3
//
//  Created by Gandi on 12/5/2024.
//
import SwiftUI

struct BookView: View {
    @ObservedObject var viewModel: BookViewModel
    @State private var isShowingAfterBookView = false

    var body: some View {
        VStack {
            // Movie image
            AsyncImage(url: URL(string: viewModel.movie.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            }
            .frame(width: 200, height: 300)
            .padding()

            // Movie title
            Text("\(viewModel.movie.title)")
                .foregroundColor(.white)
                .font(.title)
                .padding()

            // Movie seat count
            HStack {
                Text("Seats left: \(viewModel.movie.seatCount)")
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(.trailing, 10)

                // Book button
                Button(action: {
                    isShowingAfterBookView = true
                }) {
                    Text("BOOK NOW")
                        .foregroundColor(.white)
                        .font(.body)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $isShowingAfterBookView) {
                    AfterBookView(viewModel: AfterBookViewModel(movieTitle: viewModel.movie.title))
                }
            }


            // Movie details
            Text("Details: \(viewModel.movie.details)")
                .foregroundColor(.white)
                .font(.body)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Book Movie")
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}


struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(id: "1", title: "Kingdom of the Planet of the Apes", details: "Director Wes Ball breathes new life into the global, epic franchise set several generations in the future following Caesar's reign, in which apes are the dominant species living harmoniously and humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.", imageUrl: "sample-url", seatCount: 49)
        let viewModel = BookViewModel(movie: movie)
        return BookView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}

