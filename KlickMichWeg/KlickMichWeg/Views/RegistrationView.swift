//
//  RegistrationView.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    var body: some View {
        VStack {
            //Header
            HeaderView(title: "Sei gegrüßt \u{1F596}",image: "registration")
            Form {
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                // schaltet die Autokorrektur ab
                    .autocorrectionDisabled()
                TextField("E-Mail", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // schaltet die Autokorrektur ab und der erste Buchstabe bleibt damit klein
                    .autocorrectionDisabled()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Passwort", text: $viewModel.passwort)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                CustomButton(title: "Registieren", background: .green) {
                    viewModel.registration()
                }
                
            }
            .frame(width:400, height: 250)
            Spacer()
        }
    }
}

#Preview {
    RegistrationView()
}
