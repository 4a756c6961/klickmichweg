//
//  MainViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import FirebaseAuth

class MainViewModel: ObservableObject {
    @Published var currentUserID: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        
        /* handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
                DispatchQueue.main.async {
               self?.currentUserID = user?.uid ?? ""*/
                    
        
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserID = user?.uid ?? ""
          }
            
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
