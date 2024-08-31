//
//  CustomButton.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    var body: some View {
        Button {
            action()
              }
    label: {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(background)
            Text(title)
                .foregroundColor(Color.black)
                .bold()
        }
        .padding()
    }
    }
}

#Preview {
    CustomButton(title: "Button", background: .indigo) {
        
    }
}
