//
//  calendarView.swift
//  DoctorCalendarApp
//
//  Created by Kev on 9/10/25.
//

import SwiftUI
import Foundation

struct CalendarView: View {
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.white, .purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack{
                TabView{
                    Tab("Calendar", systemImage: "calendar"){
                        ccontent()
                    }
                    Tab("Settings", systemImage: "gear"){
                        settingsView()
                    }
                
                    
                }
                .accentColor(.white)
            }
            
        }
    }
}

#Preview {
    CalendarView()
}
struct ccontent: View{
    
    @State var showFullScreen = false
    
    
    
    
    var timesAvailable: [String: [String]] = ["Monday": ["9:00 - 10:00", "10:00 - 11:00", "11:00 - 12:00", "12:00 - 1:00", "1:00 - 2:00", "2:00 - 3:00", "3:00 - 4:00", "4:00 - 5:00", "5:00 - 6:00"], "Tuesday": ["9:00 - 10:00", "10:00 - 11:00", "11:00 - 12:00", "12:00 - 1:00", "1:00 - 2:00", "2:00 - 3:00", "3:00 - 4:00", "4:00 - 5:00", "5:00 - 6:00"], "Wendesday": ["9:00 - 10:00", "10:00 - 11:00", "11:00 - 12:00", "12:00 - 1:00", "1:00 - 2:00", "2:00 - 3:00", "3:00 - 4:00", "4:00 - 5:00", "5:00 - 6:00"], "Thursday": ["9:00 - 10:00", "10:00 - 11:00", "11:00 - 12:00", "12:00 - 1:00", "1:00 - 2:00", "2:00 - 3:00", "3:00 - 4:00", "4:00 - 5:00", "5:00 - 6:00"], "Friday": [ "11:00 - 12:00", "12:00 - 1:00", "1:00 - 2:00", "2:00 - 3:00", "3:00 - 4:00"], "Saturday": ["12:00 - 1:00", "1:00 - 2:00", "2:00 - 3:00", "3:00 - 4:00", "4:00 - 5:00", "5:00 - 6:00"], "Sunday": ["12:00 - 1:00", "1:00 - 2:00", "2:00 - 3:00", "3:00 - 4:00", "4:00 - 5:00", "5:00 - 6:00"]]
    
    @State var date = Date()
    
    
    var body: some View{
        
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.white, .purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                
                VStack(spacing: 30){
                    
                    
                    Text("Book an Appointment").font(.system(size: 30, weight: .bold, design: .serif))
                        
                    Spacer()
                    
                }.padding(.top, 80)
                VStack(spacing: 30){
                    
                    DatePicker("Confirm Date", selection: $date, displayedComponents: .date).datePickerStyle(.graphical)
                    
                    
                    Button("Set-Up Appointment"){
                        showFullScreen.toggle()
                    }
                    .frame(width: 195, height: 48)
                    .background(.purple.opacity(0.9))
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                    .fullScreenCover(isPresented: $showFullScreen) {
                        formView(appointment_date: $date)
                    }
                    
                
                }
            
                VStack{
                    Spacer()
                    Text("Monday - Friday 10 AM - 6 PM").font(.system(size: 18, weight: .bold, design: .rounded))
                    Text("Saturday - Sunday 12 PM - 4 PM").font(.system(size: 18, weight: .bold, design: .rounded))
                    
                }.padding(.bottom, 46)
            }
            
            
        }
        
    }
    
    
  
    
    
    
    
}
    


