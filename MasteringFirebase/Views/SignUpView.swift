//
//  SignUpView.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var logeInViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: Title
            VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Hello! please enter your detials.")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 30)
            
            //MARK: - User Name
            CSInputField(isSecureField: false, fieldTitle: "Full Name", placeHolder: .name, input: $logeInViewModel.userName)
            
            
            //MARK: - Email Text Feild
            CSInputField(isSecureField: false, fieldTitle: "Email Address", placeHolder: .email, input: $logeInViewModel.email)
            
            
            //MARK: - Password Feild
            CSInputField(isSecureField: true, fieldTitle: "Password", placeHolder: .password, input: $logeInViewModel.password)
            
            //MARK: - SignUp Button
            Button {
                authecticateNewUser()
            } label: {
                Text("Sign up")
                    .textCase(.uppercase)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.logeIn.gradient)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.bottom, 10)
            
            //MARK: - Terms and Privacy
            Text("By clicking on sign up, you have been agreed to our terms and conditions")
                .foregroundColor(.black)
                .font(.footnote)
                .fontWeight(.ultraLight)
                .padding(.bottom, 20)
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.black.opacity(0.6))
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Button {
                    logeInViewModel.currentSignView = .logeInView
                } label: {
                    Text("Log in")
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                
            }
            .padding(.bottom, 5)
        }
        .padding()
        .padding(.vertical, 15)
        
        
    }
    
    func authecticateNewUser() {
        Task {
            do {
                try await logeInViewModel.createNewUser()
                dismissScreen()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        let authMock = AuthViewModel()
        SignUpView()
            .environmentObject(authMock)
    }
}
