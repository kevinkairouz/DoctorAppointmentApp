//
//  Model.swift
//  DoctorCalendarApp
//
//  Created by Kev on 10/5/25.
//

import SwiftUI
import Foundation

struct Patient: Codable{
    
    let firstname: String
    let lastname: String
    let patient_id: Int?
}
struct Appointment: Codable{
    
    var patient_id: Int
    let appointment_date: Date
    let time: String
    let height: String
    let weight: String
    let symptoms: String
    let duration: String
    let firstname: String
    let lastname: String
    let additional: String
}

struct Suggestion: Codable{
    let suggestion_comment: String
    let suggestion_date: Date
}
