import SwiftUI



struct MenuView: View {
    @State private var isLoginViewPresented = false
    @State private var isAboutUsViewPresented = false
    @State private var isProfileViewPresented = false
    @ObservedObject var viewModel = MenuViewModel()
    @ObservedObject var userModel = UserSettings.shared
    var body: some View {
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
                }
                .padding()
                
                DisclosureGroup {
                    VStack {
                        Button(action: {
                            // Action for ticket link
                        }) {
                            Text("Movie")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background(Color.black)
                        .cornerRadius(8)
                        
                        Button(action: {
                            // Action for food link
                        }) {
                            Text("Event")
                                .foregroundColor(.white)
                                .padding()
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
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem()]) {
                        // Your horizontal scrolling list content here
                        ForEach(0..<20) { index in
                            Text("Item \(index)")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
                
                Spacer()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem()]) {
                        // Your horizontal scrolling list content here
                        ForEach(0..<20) { index in
                            Text("Item \(index)")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
                Spacer()
                
            }
            
        }
        .onAppear {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
