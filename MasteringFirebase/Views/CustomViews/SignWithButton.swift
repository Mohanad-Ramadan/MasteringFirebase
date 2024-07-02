//
//  SignWithButton.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import SwiftUI

struct SignWithButton: View {
    @State var companyLogo: ImageResource
    @State var companyName: String
    var body: some View {
        // Sign In with Google
        Button(action: {
            // Action for sign in with Google
        }) {
            HStack {
                Image(companyLogo)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Sign In With \(companyName)")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
    }
}


#Preview {
    SignWithButton(companyLogo: .appleLogo, companyName: "Apple")
}
