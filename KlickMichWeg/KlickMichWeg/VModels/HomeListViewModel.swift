//
//  HomeViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 30.07.24.
//

import Foundation
import FirebaseFirestore

class HomeListViewModel: ObservableObject {
    @Published var showNewItemView = false
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
    }
    
    func delete(id: String) {
        let database = Firestore.firestore()
        
        database.collection("users")
            .document(userID)
            .collection("homeToDos")
            .document(id)
            .delete()
    }
}
