//
//  AuthenticationManager.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 26/06/2024.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init() {}
    
    func getAuthenticatedUser() -> AuthDataResult? {
        guard let currentUser = Auth.auth().currentUser else { return nil }
        return AuthDataResult(user: currentUser)
    }
    
    @discardableResult
    func createNewUser(email: String, password: String, userName: String) async throws -> AuthDataResult {
        do {
            let authResults = try await Auth.auth().createUser(withEmail: email, password: password)
            authResults.user.createProfileChangeRequest().displayName = userName
            print(authResults.user.displayName as Any)
            return AuthDataResult(user: authResults.user)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        do {
            let authResults = try await Auth.auth().signIn(withEmail: email, password: password)
            return AuthDataResult(user: authResults.user)
        } catch {
            throw AuthErrorCode(.emailAlreadyInUse)
        }
    }
    
    func signOut() async throws {
        do { try Auth.auth().signOut()}
        catch { throw AuthErrorCode(.internalError) }
    }
}
