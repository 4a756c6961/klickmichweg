//
//  RegistrationViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class RegistrationViewModel: ObservableObject {
    @Published var name = ""
    @Published var profilimage = ""
    @Published var email = ""
    @Published var passwort = ""
    @Published var errorAlert = ""
    
    init () {}
    
    func registration () {
        guard checkregistration() else {
            return
        }
        //[weak self]-Capture-Listenmodell ist eine wichtige Technik in Swift, um Speicherlecks zu vermeiden
        Auth.auth().createUser(withEmail: email, password: passwort) { [weak self] result, error in
            guard let userID = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userID)
        }
    }
    
    private func insertUserRecord(id: String) {
        
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let database = Firestore.firestore()
        
        database.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func checkregistration() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !passwort.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorAlert = "Gib bitte deine Daten ein."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        //gibt die Mindestlänge und Maximallänge des Passworts an.
        guard passwort.count >= 6 && passwort.count <= 12 else {
            return false
        }
    return true
    }
}
