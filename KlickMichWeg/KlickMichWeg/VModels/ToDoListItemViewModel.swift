//
//  ToDoListItemViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ToDoListItemViewModel: ObservableObject {
    init() {}
    
    func toggleIsDone(item: ListItems)  {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let database = Firestore.firestore()
        database.collection("users")
            .document(uid)
            .collection("workToDos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
        
    }
    
    func isLate(item: ListItems) -> Bool {
        let currentDate = Date()
        let itemDate = Date(timeIntervalSince1970: item.date)
        return currentDate > itemDate
    }
    
    func taskisDone(item: ListItems) -> Bool {
        let task  = item.isDone
        return task
    }

}
