import SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift
import Supabase

//MARK: Have a forgot password for the signIn screen 
struct ContentView: View {
    
    @State var signInAppleTapped = false
    
    @State var signInGoogleTapped = false
    
    @State var signUpEmailTapped = false
    
    @StateObject var auth = Authentication()
    
    @State var isSecondColorsOn = false
    
    @State var color1: Color = .white
    
    @State var color2: Color = .purple
    
    @State var submittedEmail: String = ""
    
    @State var submittedPassword: String = ""
    
    @State var submitMessage: String = ""
    
    @State var showPhoneSheet = false
    
    @State var showVitalsSheet = false
    
    @State var showSignIn = false
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                LinearGradient(colors: [color1, color2], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea().animation(.easeIn(duration: 2.0_).repeatForever(autoreverses: true), value: isSecondColorsOn)
                VStack{
                    
                    Image("Image")
                        .resizable()
                        .frame(width: 210, height: 210)
                        .offset(y: -95)
                    
 
                     
                    
                    Text("\(submitMessage)")
                        .foregroundStyle(.black)
                        .offset(y:-100)
                     
                    
                    TextField("Email", text: $submittedEmail)
                        .colorScheme(.light).textInputAutocapitalization(.never).frame(width: 350)
                        .offset(y: -40)
                    
                    Rectangle()
                        .frame(width: 350, height: 2)
                        .offset(y: -40)
                    
                     
                    
                    SecureField("Password", text: $submittedPassword)
                        .colorScheme(.light).textInputAutocapitalization(.never).frame(width: 350)
                            .offset(y: 15)

                    
                    Rectangle()
                        .frame(width: 350, height: 2)
                        .offset(y: 15)
                    
                    
                    Button("Sign-Up"){
                        
                        signUpEmailTapped = true
//                        showVitalsSheet.toggle()
                        
                        Task{
                            do{
                                try await auth.signUpEmailPassword(email: submittedEmail, password: submittedPassword)
                                await MainActor.run {
                                           showVitalsSheet.toggle()
//                                           
                                       }
                            
                               
                            }
                            catch{
                                
                                submitMessage = "Sign-Up Failed"
                                throw error
                                  
        
                                }
                        }
                        
                        
                       
                    }
            
                    .frame(width: 175, height: 48)
                    .background(.purple.opacity(0.9))
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                    .offset(y: 30)
                    .font(.system(size: 17, weight: .semibold))
                    .fullScreenCover(isPresented: $showVitalsSheet) {
                        enterName()
                    }
                    
                    
                    HStack{
                        SignInWithAppleButton(.continue) { request in
                            
                            signInAppleTapped = true
                            
                            auth.startSignInWithAppleFlow()
                        
                            
                        } onCompletion: { result in
                            
                            
                            
                            
                        }
                        .frame(width: 175, height: 40)
                        
                
                            
                        
                        GoogleSignInButton.init(scheme: .light, style: .wide, state: .normal) {
                            
                            signInGoogleTapped = true
//                            showVitalsSheet.toggle()
                            
                            
                            Task{
                                do{
                                    try await auth.signInWithGoogle()
                                    submitMessage = "Success"
                                }
                                catch {
                                   print("Sign In Failed")
                                    throw error
                                       
                                    }
                                }
                            }
//                            .fullScreenCover(isPresented: $showVitalsSheet) {
//                                enterName()
//                            }
                        
                            
                            
                        }
                            .offset(y: 50)
                            .frame(width: 175)
                    }
                    
                    
                    
                    HStack{
                        Text("Already have an account?")
                            .offset(y: 315)
                        NavigationLink("Login"){
                            signInView()
                        }
                        .foregroundStyle(.white)
                        .font(.headline)
                        .offset(y:315)
                        
                    }
                    
                    
                    
                   
                    
                   
                    
                    
                    
                    
                    
                    
                    
                    
                        
                    
                        
                        
                    
                    
                }
            }
            .onAppear{
                isSecondColorsOn.toggle()
                color1 = .purple
                color2 = .white
                
            }
            
           
        }
            
        }
        
        


#Preview {
    ContentView()
}

