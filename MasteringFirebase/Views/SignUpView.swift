//
//  SignUpView.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var signInViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                //MARK: Title
                VStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Create your account!")
                        .font(.headline)
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.trailing, 10)
                }
                .padding(.bottom, 30)
                
                //MARK: - User Name
                CSInputField(isSecureField: false, fieldTitle: "Full Name", placeHolder: .name, input: $signInViewModel.userName)
                
                
                //MARK: - Email Text Feild
                CSInputField(isSecureField: false, fieldTitle: "Email Address", placeHolder: .email, input: $signInViewModel.email)
                
                
                //MARK: - Password Feild
                CSInputField(isSecureField: true, fieldTitle: "Password", placeHolder: .password, input: $signInViewModel.password)
                
                //MARK: - SignUp Button
                Button {
                    authecticateNewUser()
                } label: {
                    Text("Sign up")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.signIn.gradient)
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
                        signInViewModel.currentSignView = .signInView
                    } label: {
                        Text("Sign in")
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
        
    }
    
    func authecticateNewUser() {
        Task {
            do {
                try await signInViewModel.createNewUser()
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
