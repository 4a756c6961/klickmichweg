//
//  LoginViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import Foundation
import FirebaseAuth



class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var passwort = ""
    @Published var errorAlert = ""
    init() {}
    
    func login() {
        
        guard checklogin() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: passwort)
    }
    
   private func checklogin() -> Bool {
        
        //hier wird geprüft ob eine gültige E-Mail eingegeben wird
        guard email.contains("@") && email.contains(".") else {
            errorAlert = "Bitte gib eine gültige Mail ein."
            return false
        }
        
        
        // der guard prüft ob die Felder E-Mail und Passwort nicht leer sind, in dem die Leerzeichen am Anfang und am Ende entfernt werden, ist dieser leer wird der else block ausgeführt
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !passwort.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorAlert = "Bitte gib deine Daten ein."
            return false
        }
       return true
    }
}
