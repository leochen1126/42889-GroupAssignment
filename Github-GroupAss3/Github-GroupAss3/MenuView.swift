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
                Color(red: 28/255, green: 28/255, blue: 38/255).edgesIgnoringSafeArea(.all)
                
                VStack {
                    HeaderView()
                    
                    DisclosureGroupView(viewModel: viewModel,
                                        isMovieInfoViewPresented: $isMovieInfoViewPresented,
                                        isEventViewPresented: $isEventViewPresented,
                                        isAboutUsViewPresented: $isAboutUsViewPresented)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        MoviesView(viewModel: viewModel)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct HeaderView: View {
    @ObservedObject var userModel = UserSettings.shared
    @State private var isProfileViewPresented = false
    @State private var isLoginViewPresented = false
    @State private var isManageViewPresented = false
    var body: some View {
        HStack {
            Text("CTS")
                .foregroundColor(.white)
                .padding()
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            Button(userModel.username) {
                if userModel.username != "Login" {
                    isProfileViewPresented.toggle()
                } else {
                    isLoginViewPresented.toggle()
                }
            }
            .padding(.horizontal) // Reduce horizontal padding
            .cornerRadius(8)
            .font(.headline)
            .frame(maxWidth: 100)
            .frame(height: 40)
            .background(Color(red: 237/255, green: 49/255, blue: 140/255))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal)
            .sheet(isPresented: $isLoginViewPresented) {
                LoginView()
            }
            .sheet(isPresented: $isProfileViewPresented) {
                ProfileView()
            }
            
            if userModel.admin {
                Button("Manage") {
                    isManageViewPresented.toggle()
                }
                .padding(.horizontal) // Reduce horizontal padding
                .cornerRadius(8)
                .font(.headline)
                .frame(maxWidth: 200)
                .frame(height: 40)
                .background(Color(red: 237/255, green: 49/255, blue: 140/255))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.horizontal)
                .sheet(isPresented: $isManageViewPresented) {
                    // ManageView()
                }
            }
        }
        .padding()
    }
}

struct DisclosureGroupView: View {
    @ObservedObject var viewModel: MenuViewModel
    @Binding var isMovieInfoViewPresented: Bool
    @Binding var isEventViewPresented: Bool
    @Binding var isAboutUsViewPresented: Bool
    
    var body: some View {
        DisclosureGroup {
            VStack {
                Button(action: {
                    isMovieInfoViewPresented.toggle()
                }) {
                    Text("Movie")
                        .foregroundColor(.white)
                        .padding()
                }
                .cornerRadius(8)
                .sheet(isPresented: $isMovieInfoViewPresented) {
                    if let firstMovie = viewModel.movies.first {
                        MovieInfoView(viewModel: MovieInfoViewModel(movie: firstMovie))
                    } else {
                        Text("No movies available")
                            .foregroundColor(.white)
                    }
                }
                
                Button(action: {
                    isEventViewPresented.toggle()
                }) {
                    Text("Event")
                        .foregroundColor(.white)
                        .padding()
                }
                .cornerRadius(8)
                .sheet(isPresented: $isEventViewPresented) {
                    EventView()
                }
                 
                Button(action: {
                    isAboutUsViewPresented.toggle()
                }) {
                    Text("About Us")
                        .foregroundColor(.white)
                        .padding()
                }
                .cornerRadius(8)
                .sheet(isPresented: $isAboutUsViewPresented) {
                    AboutUsView()
                }
            }
        } label: {
            Spacer()
            Text("Click for more")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal) // Reduce horizontal padding
                .cornerRadius(8)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color(red: 237/255, green: 49/255, blue: 140/255))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.horizontal)
        }
        .padding(.bottom)
    }
}

struct MoviesView: View {
    @ObservedObject var viewModel: MenuViewModel
    
    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(300))]) {
            ForEach(viewModel.movies) { movie in
                NavigationLink(destination: BookView(viewModel: BookViewModel(movie: movie))) {
                    MovieCard(movie: movie)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            Text(movie.title)
                .foregroundColor(.white)
                .font(.body)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(width: 150)
                .padding(.bottom, 5)
            
            AsyncImage(url: URL(string: movie.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            }
            .padding(.bottom, 10)
            
            Text("Seats left: \(movie.seatCount)")
                .foregroundColor(.white)
                .font(.body)
                .padding(.bottom, 5)
        }
        .background(Color(red: 28/255, green: 28/255, blue: 38/255))
        .cornerRadius(8)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
