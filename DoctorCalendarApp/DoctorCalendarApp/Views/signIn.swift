//
//  signIn.swift
//  DoctorCalendarApp
//
//  Created by Kev on 9/12/25.
//


import SwiftUI

struct signInView: View {
    
    @State var submittedEmail: String = ""
    @State var submittedPassword: String = ""
    @State var statusMessage: String = ""
    @State var showMainView: Bool = false
    @StateObject var auth = Authentication()
    
    var body: some View {
        
        
        
        ZStack{
            LinearGradient(colors: [.white, .purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack(){
                
                Text("Sign-In").font(.system(size: 38, weight: .medium, design: .serif))
                Text(statusMessage).font(.system(size: 18, weight: .bold, design: .serif))
                
                Spacer()
            }.padding(.top, 80)
            
            VStack(spacing: 10){
                Spacer()
                
                TextField("Email", text: $submittedEmail)
                    .colorScheme(.light).textInputAutocapitalization(.never).frame(width: 350)
                   
                
                Rectangle()
                    .frame(width: 350, height: 2)
                    
                
                 
             
                

            }.padding(.bottom, 400)
            
            VStack(spacing: 10){
                Spacer()
                SecureField("Password", text: $submittedPassword)
                    .colorScheme(.light).textInputAutocapitalization(.never).frame(width: 350)
                   
                
                Rectangle()
                    .frame(width: 350, height: 2)
                    
                
            }.padding(.bottom, 280)
            
            VStack{
                Spacer()
                
                Button("Sign-In"){
                    
                    Task{
                        do{
                            let message = try await auth.signIn(email: submittedEmail, password: submittedPassword)
                            statusMessage = message
                            if statusMessage == "Success"{
                                
                                showMainView.toggle()
                                
                            }

                        }
                        catch{
                            print(error.localizedDescription)

                            throw error
                        }
                        
                    }
                    
                 
                    
                }.frame(width: 140, height: 55).background(.white.opacity(0.85)).foregroundStyle(.purple).cornerRadius(12)
                    .fullScreenCover(isPresented: $showMainView) {
                        CalendarView()
                    }
                
                
            }.padding(.bottom, 100)
            
        }
        
        
        
        
    }
}

#Preview {
    signInView()
}
