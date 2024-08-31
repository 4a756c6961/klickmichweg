//
//  ToDoListView.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    @StateObject var viewModel: TodoListViewModel
    @FirestoreQuery var items: [ListItems]
    
    @State private var selectedItem: ListItems?
    @State private var showEditItemView = false
    
    init(userID: String) {
        
        self._items = FirestoreQuery(
            collectionPath: "users/\(userID)/workToDos")
        
        self._viewModel = StateObject(wrappedValue: TodoListViewModel(userID: userID))
        
    }
    func editItem(item: ListItems) {
        DispatchQueue.main.async {
            print("Item ausgewählt: \(item)")
            self.selectedItem = item
            self.showEditItemView = true
            print("showEditItemView: \(self.showEditItemView)")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
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
               .navigationTitle("Deine Arbeits-ToDos")
               .toolbar {
                    Button {
                        viewModel.showNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                //aufruf für die View NewItemView
               .sheet(isPresented: $viewModel.showNewItemView) {
                    NewItemView(newItemPresented: $viewModel.showNewItemView)
                }
               .sheet(isPresented: $showEditItemView) {
                   if let selectedItem = selectedItem {
                       EditItemView(item: selectedItem, collectionType: .workToDos, editItemIsPresented: $showEditItemView)
                   }
                }

            }
        }
    }


//Preview
struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userID: "qTxuDqIBSnRgyrQC6yiKoEA8axZ2")
    }
}
