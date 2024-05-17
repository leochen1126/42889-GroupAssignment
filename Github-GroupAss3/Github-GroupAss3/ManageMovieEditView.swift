//
//  ManageMovieEditView.swift
//  Github-GroupAss3
//
//  Created by Myo Zaw Tun 12/5/2024.
//

import SwiftUI

struct ManageMovieEditView: View {
    @ObservedObject var viewModel: ManageMovieEditViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(movie: Movie) {
        self.viewModel = ManageMovieEditViewModel(movie: movie)
    }
    
    var body: some View {
        ZStack {
            Color(red: 28/255, green: 28/255, blue: 38/255).edgesIgnoringSafeArea(.all)
            VStack {
                editHeader
                inputFields
                updateButton
            }
            .padding()
            .background(Color(red: 38/255, green: 33/255, blue: 52/255).opacity(0.8))
            .cornerRadius(16)
            .padding()
        }
    }
    
    var editHeader: some View {
        Text("Edit Movie")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
    }
    
    var inputFields: some View {
        VStack {
            TextField("Title", text: $viewModel.title)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: viewModel.title) {
                    viewModel.isTitleValid = viewModel.isValidTitle()
                }
                .foregroundColor(viewModel.isTitleValid ? .black : .red)
            
            TextField("Details", text: $viewModel.details)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: viewModel.details) {
                    viewModel.isDetailsValid = viewModel.isValidDetails()
                }
                .foregroundColor(viewModel.isDetailsValid ? .black : .red)
            
            TextField("Image URL", text: $viewModel.imageUrl)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: viewModel.imageUrl) {
                    viewModel.isImageUrlValid = viewModel.isValidImageUrl()
                }
                .foregroundColor(viewModel.isImageUrlValid ? .black : .red)
            
            TextField("Seat Count", value: $viewModel.seatCount, formatter: NumberFormatter())
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: viewModel.seatCount) {
                    viewModel.isSeatCountValid = viewModel.isValidSeatCount()
                }
                .foregroundColor(viewModel.isSeatCountValid ? .black : .red)
        }
    }
    
    var updateButton: some View {
        Button("Update") {
            viewModel.onSuccessfulUpdate = {
                presentationMode.wrappedValue.dismiss()
            }
            viewModel.update()
        }
        .padding()
        .foregroundColor(.white)
        .background(Color(red: 237/255, green: 49/255, blue: 140/255))
        .cornerRadius(8)
        .padding()
        .disabled(!viewModel.isFormValid())
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Update Successful"),
                message: Text("The movie has been updated!"),
                dismissButton: .default(Text("OK")) {}
            )
        }
    }
}

struct ManageMovieEditView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(id: "1", title: "Sample Movie", details: "Sample Details", imageUrl: "sample-url", seatCount: 100)
        return ManageMovieEditView(movie: movie)
    }
}
