//
//  DatabaseManager.swift
//  DoctorCalendarApp
//
//  Created by Kev on 9/6/25.
//

import Foundation
import Supabase

//struct Patient: Codable{
//    
//    let firstname: String
//    let lastname: String
//    let patient_id: Int?
//}
//struct Appointment: Codable{
//    
//    var patient_id: Int
//    let appointment_date: Date
//    let time: String
//    let height: String
//    let weight: String
//    let symptoms: String
//    let duration: String
//    let firstname: String
//    let lastname: String
//    let additional: String
//}
//
//struct Suggestion: Codable{
//    let suggestion_comment: String
//    let suggestion_date: Date
//}

final class DatabaseManager: ObservableObject {
     
    var UserDB = Authentication()
    
    
    func addPatientInfoDB(patient: Patient) async throws{
        
        do{
            try await UserDB.client.from("patient").insert(patient).execute()
        }
        catch{
            throw error
        }
        
        
    }
    
    func sendDetailsToDB(info: Appointment) async throws {
        
        do{
            let patient_idresult = try await findPatientID(firstname: info.firstname, lastname: info.lastname)
            var newinfo: Appointment = info
            
            
            newinfo.patient_id = patient_idresult
            
            try await UserDB.client.from("appointment").insert(newinfo).execute()
            
            
        }
        catch{
            print(error.localizedDescription)
            print("Error inside of sendDetails to DB func")
            throw error
            
        }
        

        
    }
    
    func submitComment(comment: String, comment_date: Date) async throws {
        
        let newComment: Suggestion = Suggestion(suggestion_comment: comment, suggestion_date: comment_date)
        
        do{
            try await UserDB.client.from("suggestion").insert(newComment).execute()
        }
        catch{
            print(error.localizedDescription)
            throw error
        }
        
    }
    
    func findPatientID(firstname: String, lastname: String) async throws -> Int {
        
        //problem has to be in this function double check this function
        
        do{
            let result: [Patient] = try await UserDB.client.from("patient").select("*").eq("firstname", value: firstname.trimmingCharacters(in: .whitespaces)).eq("lastname", value: lastname.trimmingCharacters(in: .whitespaces)).execute().value
            
            
            guard let patient = result.first, let patientId = patient.patient_id else {
                print("There was an issue in findPatientID func")
                throw URLError(.badServerResponse)
                    }
                    
                    return patientId
        }
        catch{
            throw error
        }
        
    }

}
