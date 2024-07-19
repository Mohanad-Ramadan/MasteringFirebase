//
//  logeInView.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

struct LogeInView: View {
    @EnvironmentObject private var logeInViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: Title
            VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Welcome Back!")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 30)
            
            //MARK: - Email Text Feild
            CSInputField(isSecureField: false, fieldTitle: "Email Address", placeHolder: .email, input: $logeInViewModel.email)
            

            //MARK: - Password Feild
            CSInputField(isSecureField: true, fieldTitle: "Password", placeHolder: .password, input: $logeInViewModel.password)
            
            
            //MARK: - logeIn Button
            Button {
                authecticateUser()
            } label: {
                Text("Login")
                    .textCase(.uppercase)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.logeIn.gradient)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.bottom, 10)
            
            //MARK: - SignUp Button
            HStack {
                Text("Don’t have an account?")
                    .foregroundColor(.black.opacity(0.6))
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Button {
                    logeInViewModel.currentSignView = .signUpView
                } label: {
                    Text("Sign up")
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                
            }
            .padding(.bottom, 5)
            
            //MARK: - Forget Password
            Button {
                
            } label: {
                Text("Forgot Password")
                    .foregroundColor(.logeIn)
                    .font(.callout)
                    .fontWeight(.bold)
            }
            
            //MARK: - Or Divider
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.7))
                Text("OR")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.7))
            }
            .padding(.vertical, 15)
            
            //MARK: - Sign with Buttons
            SignWithButton(companyLogo: .googleIcon, companyName: "Google")
                .padding(.bottom, 20)
            SignWithButton(companyLogo: .appleLogo, companyName: "Apple")
            
        }
        .padding()
        .padding(.vertical, 15)
    }
    
    func authecticateUser() {
        Task {
            do {
                try await logeInViewModel.logeIn()
                dismissScreen()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}



#Preview {
    NavigationStack {
        let authMock = AuthViewModel()
        LogeInView()
            .environmentObject(authMock)
    }
    
}
