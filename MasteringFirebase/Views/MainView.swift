//
//  MainView.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            if authViewModel.userAuthenticated {
                FirstView()
            } else {
                AuthenticationView()
            }
        }
        .environmentObject(authViewModel)
    }
    
}

#Preview {
    MainView()
}
