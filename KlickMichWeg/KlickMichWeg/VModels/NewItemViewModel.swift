//
//  NewItemViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var date = Date()
    @Published var notiz = ""
    @Published var showAlert = false
    
    var collectionType: CollectionType = .workToDos
    
    
    init() {
        
    }
    
    func save () {
        guard canSave else {
           
            return
        }
        // get current user id die User ID soll den der Aufgaben id zu geordnet werden
        guard let uID = Auth.auth().currentUser?.uid else {
            return
        }
        //  erstellt Item
        let newID = UUID().uuidString
        let newItem = ListItems(id: newID, title: title, date: date.timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, notiz: notiz, isDone: false)
        //speichert Item
        
        let dataBase = Firestore.firestore()
        
        dataBase.collection("users")
            .document(uID)
            .collection(collectionType.rawValue)
            .document(newID)
            .setData(newItem.asDictionary())
    }
    
    //Funktion die prüft ob Variablen, wie Titel, Date und Notiz gesetzt wurden sind
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        // Stellt sicher dass das Dateobjekt innerhalb der letzten 24 Stunden liegt
        guard date >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
        
    }
    
    /*func saveToWorkToDos() {
        collectionType = "workToDos"
        save()
    }

    func saveToHome() {
        collectionType = "homeToDos"
        save()
    } */

}
