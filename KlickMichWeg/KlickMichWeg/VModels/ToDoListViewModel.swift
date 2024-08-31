//
//  ToDoListViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import Foundation

import FirebaseFirestore

class TodoListViewModel: ObservableObject {
    @Published var showNewItemView = false
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
    }
    
    func delete(id: String) {
        let database = Firestore.firestore()
        
        database.collection("users")
            .document(userID)
            .collection("workToDos")
            .document(id)
            .delete()
    }
}
