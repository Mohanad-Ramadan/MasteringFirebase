//
//  SignInView.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var signInViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: Title
            VStack {
                Text("Sign In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Welcome Back! please fill your Detials.")
                    .font(.headline)
                    .scaledToFit()
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.trailing, 10)
            }
            .padding(.bottom, 30)
            
            //MARK: - Email Text Feild
            CSInputField(isSecureField: false, fieldTitle: "Email Address", placeHolder: .email, input: $signInViewModel.email)
            

            //MARK: - Password Feild
            CSInputField(isSecureField: true, fieldTitle: "Password", placeHolder: .password, input: $signInViewModel.password)
            
            
            //MARK: - SignIn Button
            Button {
                authecticateUser()
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.signIn.gradient)
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
                    signInViewModel.currentSignView = .signUpView
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
                    .foregroundColor(.signIn)
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
                try await signInViewModel.signIn()
                dismissScreen()
                print("user signed In")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}



#Preview {
    NavigationStack {
        let authMock = AuthViewModel()
        SignInView()
            .environmentObject(authMock)
    }
    
}
