//  EditItemView.swift
//  KlickMichWeg
//
//  Created by Julia on 08.08.24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct EditItemView: View {
    @StateObject var viewModel: EditItemViewModel
    
    @Binding var editItemIsPresented: Bool
   
    init(item: ListItems, collectionType: CollectionType, editItemIsPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: EditItemViewModel(itemId: item.id, collectionType: collectionType, originalItem: item))
        _editItemIsPresented = editItemIsPresented
    }
    
    var body: some View {
        VStack {
            Text("Aufgabe bearbeiten")
                .font(.headline)

            TextField("Titel", text: $viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            DatePicker("Datum", selection: $viewModel.date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            TextEditor(text: $viewModel.notiz)
                .frame(maxHeight: .infinity)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )

            HStack {
                Button("Abbrechen"){
                    editItemIsPresented = false
                }
                .padding()
                .onAppear {
                        print("Loaded item: \(viewModel.title), \(viewModel.date), \(viewModel.notiz)")
                    }
                
                CustomButton(title: "speichern", background: .yellow) {
                    
                    if viewModel.canUpdate {
                        viewModel.update()
                        editItemIsPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    EditItemView(item: ListItems(id: "123", title: "Test", date: 1643723400, createdDate: 1643723400, notiz: "Test", isDone: false), collectionType: .workToDos, editItemIsPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
