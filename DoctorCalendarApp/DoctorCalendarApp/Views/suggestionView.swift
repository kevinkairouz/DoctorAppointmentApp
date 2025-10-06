//
//  suggestionView.swift
//  DoctorCalendarApp
//
//  Created by Kev on 9/14/25.
//

import SwiftUI

struct suggestionView: View {
    
    @State var suggestion: String = ""
    @State var date = Date()
    @StateObject var UserDB = DatabaseManager()
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.white, .purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
        
            VStack{
                Text("Enter Suggestion").font(.system(size: 30, design: .serif))
                Spacer()
            }.padding(.top, 80)
            
            VStack{
                Spacer()
                DatePicker("Today's Date", selection: $date).padding().disabled(true)
                TextField("Suggestion", text: $suggestion).textFieldStyle(.roundedBorder).padding()
                
            
                
                
            }.padding(.bottom, 385)
            
            VStack{
                Spacer()
                
                Button("Submit"){
                    Task{
                        do{
                            try await                             UserDB.submitComment(comment: suggestion, comment_date: date)

                            
                        }
                        catch{
                            print(error.localizedDescription)
                            throw error
                        }

                    }
                    //sendsuggestiontodb which takes the patientID
                    
                    
                } .frame(width: 175, height: 48)
                    .background(.purple.opacity(0.9))
                    .foregroundStyle(.white)
                    .cornerRadius(8)
            }.padding(.bottom, 165)
            
        }
    }
}

#Preview {
    suggestionView()
}
