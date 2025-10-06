//
//  appointmentForm.swift
//  DoctorCalendarApp
//
//  Created by Kev on 9/11/25.
//

import Foundation
import SwiftUI

//MARK: After user is completed we can have a thank you screen and press a button
//to take them back to the calendar 

struct formView: View{
    
//    struct Appointment: Codable{
//        
//        var patient_id: Int
//        let appointment_date: String
//        let time: String
//        let height: String
//        let weight: String
//        let symptoms: String
//        let duration: String
//        let firstname: String
//        let lastname: String
//        let additional: String?
//    }

    
    
    @Binding var appointment_date: Date
    
    @State var appointment_time = ""
    
    @State var height = ""
    
    @State var weight = ""
    
    @State var firstname = ""
    
    @State var lastname = ""
    
    @State var symptoms = ""
    
    @State var duration = ""
    
    @State var additional_notes = ""
     
    @StateObject var db = DatabaseManager()
    private func validDetails(date: String, time: String, height: String, weight: String, symp: String, duration: String, additionals: String?) -> Bool {
        
        if date.trimmingCharacters(in: .whitespaces).isEmpty || time.trimmingCharacters(in: .whitespaces).isEmpty || height.trimmingCharacters(in: .whitespaces).isEmpty || weight.trimmingCharacters(in: .whitespaces).isEmpty || symp.trimmingCharacters(in: .whitespaces).isEmpty || duration.trimmingCharacters(in: .whitespaces).isEmpty{
            
            return true
        }
        else{
            return false
        }
        
        
    }
    
    
    
    var body: some View{
        
        
   
            ZStack{
                LinearGradient(colors: [.white, .purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                ScrollView{
                    
                    VStack(){
                        
                        Text("Enter Appointment Details").font(.system(size: 30, weight: .medium, design: .serif))
                            .padding(.top, 40)
                        
                        VStack(spacing: 80){
 
                            
//                            TextField("Confirm Appointment Date (YYYY-MM-DD)", text: $appointment_date).textFieldStyle(.roundedBorder)
                            
                           
                            
                            TextField("Confirm Appointment Time (2:00)", text: $appointment_time).textFieldStyle(.roundedBorder)
                            
                            
                            TextField("Enter Height", text: $height).textFieldStyle(.roundedBorder)
                            
                            TextField("Enter Weight", text: $weight).textFieldStyle(.roundedBorder)
                            
                            
                            TextField("Enter first name", text: $firstname ).textFieldStyle(.roundedBorder)
                            
                            TextField("Enter last name", text: $lastname ).textFieldStyle(.roundedBorder)
                            
                            TextField("Enter Symptoms", text: $symptoms ).textFieldStyle(.roundedBorder)
                            
                            TextField("How long has this been occuring", text: $duration).textFieldStyle(.roundedBorder)
                            
                            TextField("Additional Info", text: $additional_notes).textFieldStyle(.roundedBorder)
                            
                            Button("Submit Details"){
                                
                                
                                    
                                    let user = Appointment(patient_id: 0, appointment_date: appointment_date, time: appointment_time, height: height, weight: weight, symptoms: symptoms, duration: duration, firstname: firstname, lastname: lastname, additional: additional_notes)
                                    
                                    Task{
                                        do{
                                            try await db.sendDetailsToDB(info: user)

                                            
                                        }
                                        catch{
                                            print("Submit Details button had an error")
                                            print(error.localizedDescription)
                                            throw error
                                        }
                                        
                                    }
                         
                                
                            }
                            .frame(width: 150, height: 55)
                            .background(.purple)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                        
                            
                        }.padding(.top, 60)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                        
                        
                    
                        
                       
                        
                        
                        
                        
                        
                        
                        
                           
                        
                    }
                    
                    
                }.defaultScrollAnchor(.top)
                
                
            }
            
            
            
        
        
        
        
        
        
    }
}
    


#Preview{
    formView(appointment_date: .constant(Date()))
}
