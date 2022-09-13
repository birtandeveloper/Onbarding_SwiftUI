import SwiftUI

struct OnboardingView: View {
    
    //Transitions
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    //States
    @State var onboardingPageState: Int = 0
    @State var name: String = ""
    @State var age: Double = 25
    @State var gender: String = ""
    
    //Alerts
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    //AppStorage
    @AppStorage("name") var userName: String?
    @AppStorage("age") var userAge: Int?
    @AppStorage("gender") var userGender: String?
    @AppStorage("sign_check") var userSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            //content
            ZStack {
                switch onboardingPageState {
                case 0:
                    welcomeScreen.transition(transition)
                case 1:
                    userNameScreen.transition(transition)
                case 2:
                    ageScreen.transition(transition)
                case 3:
                    genderScreen.transition(transition)
                default: RoundedRectangle(cornerRadius: 20).foregroundColor(.yellow)
                }
            }
            //buttons
            VStack {
                Spacer()
                bottomButton
                
            }.padding(40)
        }.alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
    
    struct OnboardingView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingView().background(RadialGradient(colors: [Color(.blue), Color(.orange)], center: .topLeading, startRadius: 5, endRadius: UIScreen.main.bounds.height).ignoresSafeArea())
            
        }
    }
}

// MARK: COMPONENTS

extension OnboardingView {
    
    private var bottomButton: some View {
        
        Text(
            onboardingPageState == 0 ? "SIGN UP" : onboardingPageState == 3 ?  "GET STARTED" : "NEXT")
            .font(.headline)
            .foregroundColor(.purple)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .onTapGesture {
                controllerButton()
            }
    }
    
    private var welcomeScreen: some View {
        
        VStack(spacing: 30) {
            Spacer()
            Image("sport")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300).foregroundColor(.white)
            
            Text("Welcome Our App").foregroundColor(.white).font(.largeTitle).fontWeight(.semibold)
            
            Text("With this app you could track your healt conditions day by day according to your daily efforts like running or drinking water etc.").foregroundColor(.white).fontWeight(.medium).font(.title2)
            Spacer()
            Spacer()
        }.multilineTextAlignment(.center)
            .padding(30)
        
    }
    
    private var userNameScreen: some View {
        
        VStack(spacing: 30) {
            Spacer()
            Text("Please Enter Your Name").foregroundColor(.white).font(.largeTitle).fontWeight(.semibold)
            
            TextField("What is Your Name...", text: $name).font(.headline)
                .frame(height: 55).padding(.horizontal).background(.white).cornerRadius(10)
            Image("name")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300).foregroundColor(.white)
            Spacer()
            Spacer()
        }.padding(30)
        
    }
    
    private var ageScreen: some View {
        
        VStack(spacing: 30) {
            Spacer()
            Text("How old are you?").foregroundColor(.white).font(.largeTitle).fontWeight(.semibold)
            Text("\(String(format: "%.0f",age))").font(.largeTitle).fontWeight(.semibold).foregroundColor(.white)
            Slider(value: $age, in: 18...100, step: 1).accentColor(.white)
            Image("age")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300).foregroundColor(.white)
            
            Spacer()
            Spacer()
        }.padding(30)
        
    }
    
    private var genderScreen: some View {
        
        VStack(spacing: 30) {
            Spacer()
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Picker(
                selection: $gender,
                label:
                    Text(gender.count > 1 ? gender : "Select Your Gender"),
                content: {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("I don't want to Indicate").tag("I don't want to Indicate")
                    
                }).pickerStyle(MenuPickerStyle()).font(.headline)
                .foregroundColor(.purple)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(10)
            Image("gender")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300).foregroundColor(.white)
            Spacer()
            Spacer()
        }.padding(30)
        
    }
    
}

// MARK: FUNCTIONS

extension OnboardingView {
    
    func controllerButton() {
        
        //CHECK TEXT DATA
        
        switch onboardingPageState {
        case 1:
            guard name.count >= 3 else {
                showAlert(title: "Please Enter a Valid Name!")
                return
            }
            
        case 3:
            guard gender.count > 3 else {
                showAlert(title: "Please Select a Gender")
                return
            }
            
        default:
            break
        }
        
        //PAGE CONTROLLER
        
        if onboardingPageState == 3 {
            
            signupCheck()
            
        } else {
            
            withAnimation(.spring()) {
                
                onboardingPageState += 1
            }
            
        }
        
        
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    func signupCheck() {
        
        userName = name
        userAge = Int(age)
        userGender = gender
        withAnimation(.spring()) {
            userSignedIn = true
        }
        
        
    }
    
}


