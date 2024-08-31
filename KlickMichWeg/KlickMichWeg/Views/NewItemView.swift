//
//  NewItemView.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack{
            Text("Neue Aufgabe")
                .font(.system(size:20))
                .bold()
            Form {
                // Titel der neuen Aufgabe
                TextField("Titel", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Datum
                DatePicker("Datum", selection: $viewModel.date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                Picker("Kategorie", selection: $viewModel.collectionType) {
                                   ForEach(CollectionType.allCases) { type in
                                       Text(type.displayName).tag(type)
                                   }
                               }
                               .pickerStyle(SegmentedPickerStyle()) // Optional: SegmentedPickerStyle
                // Notiz
                TextEditor(text:$viewModel.notiz)
                    .frame(maxWidth: 300, maxHeight: 100)
                    .overlay(
                    RoundedRectangle(cornerRadius: 0)
                       .stroke(Color.accentColor, lineWidth: 1)
                    )
                    .overlay(
                            Text("Notiz")
                               .foregroundColor(.gray)
                               .opacity(viewModel.notiz.isEmpty ? 1 : 0)
                               
                        )
                //Button
                   
                
                CustomButton(title: "speichern", background: .mint) {
                    
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Fehler"), message: Text("Aufgabentitel ausfüllen und Datum auswählen"))
            }
        }
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
