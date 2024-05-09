import SwiftUI

struct MenuView: View {
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
                    Button("Login") {
                        // Action for login button
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
                }
                .padding()
                
                DisclosureGroup {
                    VStack {
                        Button(action: {
                            // Action for ticket link
                        }) {
                            Text("Tickets")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background(Color.black)
                        .cornerRadius(8)
                        
                        Button(action: {
                            // Action for food link
                        }) {
                            Text("Food")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background(Color.black)
                        .cornerRadius(8)
                    }
                } label: {
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(8)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
