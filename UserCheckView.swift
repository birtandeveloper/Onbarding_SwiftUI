import SwiftUI

struct UserCheckView: View {
    
    @AppStorage("sign_check") var userSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            
            //background
            RadialGradient(colors: [Color(.blue), Color(.orange)], center: .topLeading, startRadius: 5, endRadius: UIScreen.main.bounds.height).ignoresSafeArea()
            
            if userSignedIn {
                ProfileView().transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            } else {
                OnboardingView().transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
        }
    }
}


struct UserCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UserCheckView()
    }
}
}
