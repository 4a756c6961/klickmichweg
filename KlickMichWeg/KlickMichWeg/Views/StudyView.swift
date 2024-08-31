//
//  StudyView.swift
//  KlickMichWeg
//
//  Created by Julia on 08.08.24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct StudyView: View {
    @StateObject var viewModel: StudyListViewModel
    @FirestoreQuery var items: [ListItems]
    @State private var selectedItem: ListItems? 
    @State private var showEditItemView = false
    
    // Initalisierung der StudyView mit der userID als Parameter
    init(userID: String) {
        // Abfrage, holt sich alle Listeneinträge aus der DB eines Users
        self._items = FirestoreQuery(
            collectionPath: "users/\(userID)/studyToDos")
        // erstellt neue Instanz der StudyListViewModel mit der userID
        self._viewModel = StateObject(wrappedValue: StudyListViewModel(userID: userID))
      }
    
    // wird aufgerufen wenn ein Listenelement bearbeitet werden soll
    func editItem(item: ListItems) {
        DispatchQueue.main.async {
            print("Item ausgewählt: \(item)")
            //holt sich das ausgewählte Element
            self.selectedItem = item
            //setzt showEditItemView auf true, was die EditItemView aufruft
            self.showEditItemView = true
            print("showEditItemView: \(self.showEditItemView)")
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                  List(items) { item in
                    StudyListItemView(item: item)
                      // Wischactions, wenn bei einem Element nach rechts gewischt wird
                      // können diese Bearbeiten (dargestellt in Blau) oder gelöscht werden (dargestellt in Rot)
                        .swipeActions {
                            Button("Löschen") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                        .swipeActions {
                            Button("Bearbeiten") {
                                print("Tapped Bearbeiten for item: \(item)")
                                self.editItem(item: item)
                            }
                            .tint(.blue)
                        }
                    
                    }
                       .listStyle(PlainListStyle())
                    
                }
               .navigationTitle("Aufgabenübersicht")
               .toolbar {
                   //  Button der die showNewItemView auf true setzt und somit die .sheet (isPresented...) aufruft
                    Button {
                        viewModel.showNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                //aufruf für die View NewItemView, speichert alle Eingabe der neuen Aufgabe
               .sheet(isPresented: $viewModel.showNewItemView) {
                    NewItemView(newItemPresented: $viewModel.showNewItemView)
                }
                //Aufruf der EditItemView, das markierte Item wird angezeigt und die Eingaben können überarbeitet und gespeichert werden
               .sheet(isPresented: $showEditItemView) {
                   if let selectedItem = selectedItem {
                       EditItemView(item: selectedItem, collectionType: .studyToDos, editItemIsPresented: $showEditItemView)
                   }
                }
            }
        }
    }


//Preview
struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView(userID: "qTxuDqIBSnRgyrQC6yiKoEA8axZ2")
    }
}
