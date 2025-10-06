//
//  Authentication.swift
//  DoctorCalendarApp
//
//  Created by Kev on 9/6/25.
//

import Foundation
import SwiftUI
import Supabase
import GoogleSignIn
import GoogleSignInSwift
import UIKit
import AuthenticationServices
import CryptoKit


class Authentication: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding, ObservableObject {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
    
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first?
                .windows
                .first ?? ASPresentationAnchor()
        
    }
    
    
    var currentNonce: String? 
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://wflbhqopsxbiaevdkqrl.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndmbGJocW9wc3hiaWFldmRrcXJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcxOTEzMDEsImV4cCI6MjA3Mjc2NzMwMX0.wO5j48JixHeGHyIpRAzoVLu93a1ycyjzi-GnrAowrZw")
     
    
    func signInWithGoogle() async throws{
        
     //first we must get the topViewController
        
        let rootView = UIApplication.shared.connectedScenes.compactMap { scene in scene as? UIWindowScene }
            .first?
            .windows
            .first?
            .rootViewController ?? nil
        
        do{
            let token = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootView!)
            let userToken = token.user.idToken?.tokenString
            
            if let userToken = userToken{
                
                try await client.auth.signInWithIdToken(credentials: OpenIDConnectCredentials(provider: .google, idToken: userToken))
                
                
            }
            else{
                print("Error with token")
            }
           
            
            
        }
        catch{
            throw URLError(.badURL)
        }
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }


    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

        
    func startSignInWithAppleFlow() {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }
     
    func signUpEmailPassword(email: String, password: String) async throws {
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty == true || password.trimmingCharacters(in: .whitespaces).isEmpty == true 
        {
            
            return
        }
        else{
            
            do{
                try await client.auth.signUp(email: email, password: password) 
            }
            catch{
                throw error
            }
            
            
        }
        
    }

    
    
    
    func signOut() async throws{
        
        do{
            try await client.auth.signOut()

            
        }
        catch{
            print(error.localizedDescription)
            throw error
        }
    }
    
    func signIn(email: String, password: String) async throws -> String {
        
        do{
            try await client.auth.signIn(email: email, password: password)
            return "Success"
            
        }
        catch{
            print(error.localizedDescription)
            return "Account Not Found"
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
}
extension Authentication {

  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let nonce = currentNonce else {
        fatalError("Invalid state: A login callback was received, but no login request was sent.")
      }
      guard let appleIDToken = appleIDCredential.identityToken else {
        print("Unable to fetch identity token")
        return
      }
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        return
      }
        Task{
            do{
                try await client.auth.signInWithIdToken(credentials: OpenIDConnectCredentials(provider: .apple, idToken: idTokenString, nonce: nonce))
            }
            catch{
                print(error.localizedDescription)
                throw error
            }
         
            
        }
       
      // Initialize a Firebase credential, including the user's full name.
     
      // Sign in with Firebase.
      
    }
  }

  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
    print("Sign in with Apple errored: \(error)")
  }

}
