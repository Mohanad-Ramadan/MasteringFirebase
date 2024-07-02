//
//  FirstView.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

struct FirstView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismissScreen
    
    var body: some View {
        NavigationStack {
            Button {
                signOut()
                dismissScreen()
            } label: {
                Text("Log out")
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func signOut() {
        Task { 
            do {
                try await AuthenticationManager.shared.signOut()
                authViewModel.userAuthenticated = false
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        FirstView()
    }
}
