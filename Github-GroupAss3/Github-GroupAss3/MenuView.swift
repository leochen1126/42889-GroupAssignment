import SwiftUI

struct MenuView: View {
    @State private var isLoginViewPresented = false
    @State private var isMovieInfoViewPresented = false
    @State private var isEventViewPresented = false
    @State private var isAboutUsViewPresented = false
    @State private var isProfileViewPresented = false
    @State private var isManageViewPresented = false
    @ObservedObject var viewModel = MenuViewModel()
    @ObservedObject var userModel = UserSettings.shared
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text("CTS")
                            .foregroundColor(.white)
                            .padding()
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        
                        Button(userModel.username) {
                            // If the user is logged in, go to the profile view
                            if userModel.username != "Login" {
                                // Navigate to ProfileView
                                isProfileViewPresented.toggle()
                            } else {
                                // Present the login view
                                isLoginViewPresented.toggle()
                            }
                        }
                        .padding(.horizontal) // Reduce horizontal padding
                        .cornerRadius(8)
                        .font(.headline)
                        .frame(maxWidth: 100)
                        .frame(height: 40)
                        .background(.gray)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.horizontal)
                        .sheet(isPresented: $isLoginViewPresented) {
                            // Present the login view as a modal sheet
                            LoginView()
                        }
                        .sheet(isPresented: $isProfileViewPresented) {
                            // Present the login view as a modal sheet
                            ProfileView()
                        }
                        if userModel.admin {
                            Button("Manage") {
                                // Action for Manage button
                                isManageViewPresented.toggle()
                            }
                            .padding(.horizontal) // Reduce horizontal padding
                            .cornerRadius(8)
                            .font(.headline)
                            .frame(maxWidth: 100)
                            .frame(height: 40)
                            .background(.gray)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(.horizontal)
                            .sheet(isPresented: $isManageViewPresented) {
                                // Present the manage view as a modal sheet
                                //lead to ManageView()
                            }
                        }
                    }
                    .padding()
                    
                    DisclosureGroup {
                        VStack {
                            Button(action: {
                                isMovieInfoViewPresented.toggle()
                            }) {
                                Text("Movie")
                                    .foregroundColor(.white)
                                    .padding()
                                    .sheet(isPresented: $isMovieInfoViewPresented) {
                                        
                                    }
                            }
                            .background(Color.black)
                            .cornerRadius(8)
                            
                            Button(action: {
                                isEventViewPresented.toggle()
                            }) {
                                Text("Event")
                                    .foregroundColor(.white)
                                    .padding()
                                    .sheet(isPresented: $isEventViewPresented) {
                                        EventView()
                                    }
                            }
                            .background(Color.black)
                            .cornerRadius(8)
                            Button(action: {
                                isAboutUsViewPresented.toggle()
                            }) {
                                Text("About us")
                                    .foregroundColor(.white)
                                    .padding()
                                    .sheet(isPresented: $isAboutUsViewPresented) {
                                        AboutUsView()
                                    }
                            }
                        }
                    } label: {
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal) // Reduce horizontal padding
                            .cornerRadius(8)
                            .font(.headline)
                            .frame(maxWidth:.infinity)
                            .frame(height: 40)
                            .background(.gray)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(.horizontal)
                    }
                    .padding(.bottom) // Add bottom padding
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem(.fixed(300))]) {
                            ForEach(viewModel.movies) { movie in
                                NavigationLink(destination: BookView(viewModel: BookViewModel(movie: movie))) {
                                    VStack {
                                        // Title
                                        Text(movie.title)
                                            .foregroundColor(.white)
                                            .font(.body)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.center)
                                            .frame(width: 150)
                                            .padding(.bottom, 5)
                                        
                                        // Asynchronously load the movie image from the URL
                                        AsyncImage(url: URL(string: movie.imageUrl)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 150)
                                                .cornerRadius(8)
                                        } placeholder: {
                                            // Placeholder while loading
                                            Rectangle()
                                                .foregroundColor(.gray)
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 150)
                                                .cornerRadius(8)
                                        }
                                        .padding(.bottom, 10)
                                        
                                        // Movie seat count
                                        Text("Seats left: \(movie.seatCount)")
                                            .foregroundColor(.white)
                                            .font(.body)
                                            .padding(.bottom, 5)
                                    }
                                    .background(Color.black)
                                    .cornerRadius(8)
                                    .padding()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                }
                
            }
            .onAppear {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
