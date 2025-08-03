//
//  LoginView.swift
//  AuthenticationProject
//
//  Created by Maahin Beri on 6/13/25.
//

import SwiftUI
import AuthenticationServices
import LocalAuthentication

struct LoginView: View {
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView() {
            ZStack {
                Color(white: 0.1)
                    .ignoresSafeArea()
                
                VStack (spacing: 10){
                    
                    Button(action: handleBiometricAuth) {
                        ZStack {
                            Color.black
                            HStack {
                                Image(systemName: "faceid")
                                Text ("Sign In with FaceID")
                                    .tint(Color.white)
                            }
                        }
                    }
                    .frame(width: 300, height: 50)
                    .cornerRadius(10.0)
                    .scaledToFill()
                    
                    
                    SignInWithAppleButton(.signIn) { request in
                        // Create a request for Sign In
                        request.requestedScopes = [.fullName, .email]
                        
                    } onCompletion: { result in
                        switch result {
                        case .success(let authorization):
                            handleSuccessfulLogin(authorization: authorization)
                        case .failure(let error):
                            handleLoginError(error: error)
                        }
                    }
                    .frame(width: 300, height: 50)
                    
                    NavigationLink(destination:
                       AuthenticatedView(),
                       isActive: self.$isLoggedIn) {
                         EmptyView()
                    }.hidden()
                }
            }
        }
    }
    
    private func handleSuccessfulLogin(authorization: ASAuthorization) {
        print("Successful login with \(authorization)")
        if let userDetails = authorization.credential as? ASAuthorizationAppleIDCredential {
                    
                    if userDetails.authorizedScopes.contains(.fullName) {
                        print(userDetails.fullName?.givenName ?? "No name provided")
                    }
                    
                    if userDetails.authorizedScopes.contains(.email) {
                        print(userDetails.email ?? "Email not available")
                    }
                }
    }
    
    private func handleLoginError(error: Error) {
            print("Login Error: \(error.localizedDescription)")
        }
    
    private func handleBiometricAuth() {
        print("Face ID")
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.isLoggedIn = true
                        print("Authentication successful")
                    } else {
                        showBiometricFailed()
                        print("Authentication failed: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        } else {
            showBiometricFailed()
            print("Face ID not available: \(error?.localizedDescription ?? "Unknown reason")")
        }
    }
    
    private func showBiometricFailed() {
        // Create a UIAlertView Controller
        let informationAlert = UIAlertController(title: "Face ID Failed" , message: "Unable to authenticate with Face ID", preferredStyle: .alert)
        
        // Create an action for the Ok button
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        // Add the actions to the Alert and present it
        informationAlert.addAction(okAction)
        
        let viewController = UIApplication.shared.windows.first!.rootViewController!
        viewController.present(informationAlert, animated: true, completion: nil)
    }
    
}

