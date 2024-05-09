import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        
                        
                        HStack {
                            Spacer()
                            Button(" Login  ") {
                                // Add action to perform login
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding()
                            Spacer()
                            
                            NavigationLink(destination: RegisterView()) {
                                Text("Register")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(16)
                    .padding()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
