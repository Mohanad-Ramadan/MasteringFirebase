//
//  AuthenticationView.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

enum SignViewType { case logeInView, signUpView }


struct AuthenticationView: View {
    @EnvironmentObject var signViewModel: AuthViewModel
    @State var animatelogeIn: Bool = true
    @State var animateSignUP: Bool = false
    // signView boolen computed property
    var islogeInView: Bool { signViewModel.currentSignView == .logeInView }
    
    // body
    var body: some View {
        NavigationStack{
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.logeIn, Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                LogeInView()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .offset(x: islogeInView ? 0:-500)
                    .padding()
                
                SignUpView()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .offset(x: !islogeInView ? 0:500)
                    .padding()
                    .transition(.slide)
                
            }
            .animation(.smooth(), value: islogeInView)
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
