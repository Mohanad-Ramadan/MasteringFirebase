//
//  Validator.swift
//  MasteringFirebase
//
//  Created by Mohanad Ramdan on 17/07/2024.
//

import Foundation

enum EmailError: Error {
    case isEmpty
    case isNotValidEmailAddress
    case isNotValidEmailLength
}

struct Validator {
    private static let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
            + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
            + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
            + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
            + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
            + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
            + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        static func email(_ string: String) throws {
            if string.isEmpty == true {
                throw EmailError.isEmpty
            }

            if isValid(input: string,
                       regEx: emailRegEx,
                       predicateFormat: "SELF MATCHES[c] %@") == false {
                throw EmailError.isNotValidEmailAddress
            }

            if maxLength(emailAddress: string) == false {
                throw EmailError.isNotValidEmailLength
            }
        }

        // MARK: - Private

        private static func isValid(input: String, regEx: String, predicateFormat: String) -> Bool {
            return NSPredicate(format: predicateFormat, regEx).evaluate(with: input)
        }

        private static func maxLength(emailAddress: String) -> Bool {
            // 64 chars before domain and total 80. '@' key is part of the domain.
            guard emailAddress.count <= 80 else {
                return false
            }

            guard let domainKey = emailAddress.firstIndex(of: "@") else { return false }

            return emailAddress[..<domainKey].count <= 64
        }
    
}
