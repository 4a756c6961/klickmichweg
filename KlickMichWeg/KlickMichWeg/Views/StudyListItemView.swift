//
//  StudyListItemView.swift
//  KlickMichWeg
//
//  Created by Julia on 08.08.24.
//

import SwiftUI

struct StudyListItemView: View {
    @StateObject var viewModel = StudyListItemViewModel()
    let item:ListItems
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.title)
                    .font(.body)
                    .font(.title2)
                    .bold()
                    .foregroundColor(viewModel.isLate(item: item) ? .red : viewModel.taskisDone(item: item) ? .green : .primary)
                   
                    
                Text(item.notiz)
                    .font(.body)
                    .font(.footnote)
                Text("\(Date(timeIntervalSince1970: item.date).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(viewModel.isLate(item: item) ? .red : .primary)
            }
            
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")            }
        }
    }
}

#Preview {
    StudyListItemView(item: .init(id: "0123", title: "Melanie anrufen", date: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, notiz: "Besprechung nächste Marketingaktion", isDone: false))
}
