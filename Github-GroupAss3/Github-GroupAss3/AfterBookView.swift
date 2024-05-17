//
//  AfterBookView.swift
//  Github-GroupAss3
//
//  Created by Gandi on 12/5/2024.
//  Edited by Anna Huang on 13/5/2024 for seats selection and no payment.
//
import SwiftUI

struct AfterBookView: View {
    init(viewModel: AfterBookViewModel) {
        self.viewModel = viewModel
    } //seats
    @ObservedObject var viewModel: AfterBookViewModel
    @State private var userName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var isShowingActionSheet = false
    @Environment(\.presentationMode) var presentationMode

    private var seatsViewModel = SeatsViewModel(movieTitle: "Sample Movie Title")   //seats
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.movieTitle)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()

                SeatsView(viewModel: seatsViewModel)    //seats
                TextField("Name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Phone", text: $phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    // Show success action sheet
                    isShowingActionSheet = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        seatsViewModel.confirmBooking() //seats
                        // Upload booking details to database
                        viewModel.uploadBookingDetails(userName: userName, phone: phone, email: email, movieTitle: viewModel.movieTitle)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Book Now") //booking only
                }
                .padding()

                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Book \(viewModel.movieTitle)", displayMode: .inline)
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
