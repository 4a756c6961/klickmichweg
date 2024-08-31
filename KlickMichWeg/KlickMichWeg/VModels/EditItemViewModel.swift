//
//  EditItemViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 09.08.24.
//
import FirebaseAuth
import FirebaseFirestore

class EditItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var date = Date()
    @Published var notiz = ""
    @Published var showAlert = false
    
    var collectionType: CollectionType = .workToDos
    var itemId: String = ""
    var originalItem: ListItems?
    
    init(itemId: String, collectionType: CollectionType, originalItem: ListItems) {
        self.itemId = itemId
        self.collectionType = collectionType
        self.originalItem = originalItem
        self.title = originalItem.title
        self.date = Date(timeIntervalSince1970: originalItem.date)
        self.notiz = originalItem.notiz
    }
    
    func update() {
        guard canUpdate else {
            return
        }
        // aktuelle userID
        guard let uID = Auth.auth().currentUser?.uid else {
            return
        }
        // update Item
        let updatedItem = ListItems(id: itemId, title: title, date: date.timeIntervalSince1970, createdDate: originalItem?.createdDate ?? 0, notiz: notiz, isDone: originalItem!.isDone)
        // update Item in der Firestore
        let dataBase = Firestore.firestore()
        dataBase.collection("users")
            .document(uID)
            .collection(collectionType.rawValue)
            .document(itemId)
            .updateData(updatedItem.asDictionary())
    }
    //Prüffunktion ob alle Daten gesetzt sind
    var canUpdate: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        // stellt sicher dass das gesetzte Datum bzw. Zeitintervall nicht in den letzten 24 Stunden liegt
        guard date >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
