//
//  StudyListViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 08.08.24.
//


import Foundation
import FirebaseFirestore

class StudyListViewModel: ObservableObject {
    @Published var showNewItemView = false
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
    }
    
    func delete(id: String) {
        let database = Firestore.firestore()
        
        database.collection("users")
            .document(userID)
            .collection("studyToDos")
            .document(id)
            .delete { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                } else {
                    print("Document successfully deleted")
                }
            }
    }
    
    func edit(id: String, newTitle: String, newDate: Date, newNotiz: String) {
        let database = Firestore.firestore()
        
        database.collection("users")
            .document(userID)
            .collection("studyToDos")
            .document(id)
            .updateData([
                "title": newTitle,
                "date": newDate.timeIntervalSince1970,
                "notiz": newNotiz
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
    }
}
