//
//  enterName.swift
//  DoctorCalendarApp
//
//  Created by Kev on 9/8/25.
//


import SwiftUI




struct enterName: View {
    
    //Button("Show Alert") {
    //    showingAlert = true
    //}
    //.alert("Important message", isPresented: $showingAlert) {
    //    Button("OK", role: .cancel) { }
    //} use this for the alert if there are creds missing firstname and lastname
    
    @StateObject var db = DatabaseManager()
    
    @State var showFullCover = false
    
    @State var firstName = ""
    @State var lastName = ""
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.white, .purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack(spacing: 50){
                Text("What's Your Name?").font(.system(size: 38, weight: .medium, design: .serif))
                    .padding(.top, 10)
                
                TextField("First Name", text: $firstName).textFieldStyle(.roundedBorder).padding()
                    .autocorrectionDisabled()
                    .offset(y: 60)
                
                TextField("Last Name", text: $lastName).textFieldStyle(.roundedBorder).padding()
                    .autocorrectionDisabled()
                    .offset(y: 80)
                 
                
                Button("Enter"){
                     
                    if lastName.trimmingCharacters(in: .whitespaces).isEmpty == false && firstName.trimmingCharacters(in: .whitespaces).isEmpty == false{
                        
                        let patient = Patient(firstname: firstName, lastname: lastName, patient_id: nil)
                        
                        Task{
                            
                            do{
                                try await db.addPatientInfoDB(patient: patient)
                                showFullCover.toggle()
                                
                                
                            }
                            catch{
                                print("Error with database")
                                
                            }
                            
                        }
                        
                    }
                    else{
                        //we insert alert here
                        //TODO
                    }
                  
                }
                .frame(width: 175, height: 48)
                .background(.purple.opacity(0.9))
                .foregroundStyle(.white)
                .cornerRadius(8)
                .offset(y: 100)
                .font(.system(size: 17, weight: .semibold))
                
                .fullScreenCover(isPresented: $showFullCover) {
//                        ccontent()
                    CalendarView()
                }
                
                
            }

        }
        
        
        
        
        
    }
}

#Preview {
    enterName()
}
