import SwiftUI

struct ProfileView: View {
    
    @AppStorage("name") var userName: String?
    @AppStorage("age") var userAge: Int?
    @AppStorage("gender") var userGender: String?
    @AppStorage("sign_check") var userSignedIn: Bool = false
    
    var body: some View {
              
        VStack(spacing: 10) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text("Your Name is: \(userName ?? "unknown")")
            Text("Your Age is: \(userAge ?? 0)")
            Text("Your Gender is: \(userGender ?? "unknown")")
            Text("SIGN OUT")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(.orange)
                .cornerRadius(10)
                .onTapGesture {
                    
                 signOut()
                }
            
            
            
            
        }.font(.body).foregroundColor(.orange).padding().padding(.all, 20).background(.white).cornerRadius(10).shadow(radius: 10).padding()
    }
    
    func signOut() {
        
        
        userName = nil
        userAge = nil
        userGender = nil
        withAnimation(.spring()) {
            userSignedIn = false
        }
        
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

