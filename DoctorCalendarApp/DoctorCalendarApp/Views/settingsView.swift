//
//  settingsView.swift
//  DoctorCalendarApp
//
//  Created by Kev on 9/10/25.
//

import SwiftUI

struct settingsView: View {
    
    
    let options: [String] = ["Log Out", "Leave a Suggestion"]
    
    @StateObject var UserDB = Authentication()
    
    @State var suggestioOn = false
    @State var isOn = false
    
    @State var infoShowing = ""
    
    //Have two bindings so we can get the first name and last name and
    //return the result of the query select * from Patient where firstname = firstname and lastname = lastname 
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.white, .purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack{
                
                Text("Settings").font(.system(size: 38, weight: .medium, design: .serif))
                Spacer()
            }.padding(.top, 65)
            
            
            VStack{
               
                List{
                  
                    Button("Log Out"){
                        Task{
                            do{
                               try await UserDB.signOut()
                                isOn.toggle()
                                //call the loginView
                            }
                            catch{
                                print(error.localizedDescription)
                                throw error 
                            }
                        }
                        
                    }.foregroundStyle(.black).fullScreenCover(isPresented: $isOn) {
                        ContentView()
                    }
                    
                    Button("Leave a Suggestion"){
                        
                        suggestioOn.toggle()
                        
                        
                        
                        
                    }.foregroundStyle(.black).fullScreenCover(isPresented: $suggestioOn){
                        suggestionView()
                    }
                        
                }.scrollContentBackground(.hidden).offset(y: 120)
                
            }
            VStack{
                Spacer()
                Text(infoShowing)
            }.padding(.bottom, 100)
            }
        }
}


#Preview {
    settingsView()
}
