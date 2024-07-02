//
//  AuthenticationView.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

enum SignViewType { case signInView, signUpView }


struct AuthenticationView: View {
    @EnvironmentObject var signViewModel: AuthViewModel
    @State var animateSignIn: Bool = true
    @State var animateSignUP: Bool = false
    // signView boolen computed property
    var isSignInView: Bool { signViewModel.currentSignView == .signInView }
    
    // body
    var body: some View {
        NavigationStack{
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.signIn, Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                SignInView()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .offset(x: animateSignIn ? 0:-500)
                    .padding()
                
                SignUpView()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .offset(x: animateSignUP ? 0:500)
                    .padding()
            }
            .onChange(of: isSignInView) { _, currentViewSignIn in
                withAnimation {
                    animateSignIn = currentViewSignIn ? true:false
                    animateSignUP = currentViewSignIn ? false:true
                }
            }
        }
    }
    
}


#Preview {
    NavigationStack {
        let authMock = AuthViewModel()
        AuthenticationView()
            .environmentObject(authMock)
    }
}
