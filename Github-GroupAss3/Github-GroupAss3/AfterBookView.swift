//
//  AfterBookView.swift
//  Github-GroupAss3
//
//  Created by Gandi on 12/5/2024.
//
import SwiftUI

struct AfterBookView: View {
    @ObservedObject var viewModel: AfterBookViewModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isShowingActionSheet = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.movieTitle)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()

                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    // Show success action sheet
                    isShowingActionSheet = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        // Upload booking details to database
                        viewModel.uploadBookingDetails(firstName: firstName, lastName: lastName, email: email, movieTitle: viewModel.movieTitle)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Pay Now")
                }
                .padding()

                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Pay \(viewModel.movieTitle)", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("BACK")
                        .foregroundColor(.white)
                        .font(.body)
                }
            })
            .actionSheet(isPresented: $isShowingActionSheet) {
                ActionSheet(
                    title: Text("Booking Successful!"),
                    buttons: []
                )
            }
        }
    }
}

struct AfterBookView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AfterBookViewModel(movieTitle: "Sample Movie Title")
        return AfterBookView(viewModel: viewModel)
    }
}
