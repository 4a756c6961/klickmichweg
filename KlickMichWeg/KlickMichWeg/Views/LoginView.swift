//
//  LoginView.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // HeaderView
                HeaderView(title: "klick mich weg - Deine ToDos", image: "Login")
                    
                // Loginfeld
                
                Form {
                    if !viewModel.errorAlert.isEmpty {
                        Text(viewModel.errorAlert)
                            .foregroundColor(Color.red)
                    }
                    
                    // zeigt hier InputLabel an mit den Placeholdern
                    TextField("E-Mail", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .background(Color.indigo)
                        .cornerRadius(5.0)
                    
                    SecureField("Passwort", text: $viewModel.passwort)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.indigo)
                        .cornerRadius(5.0)
                    
                    CustomButton(title: "Login", background: .indigo) {
                        // Aufruf des ViewModels zum Login
                        viewModel.login()
                    }
                }
                .frame(width:400, height: 250)
                
                // create Account
                VStack {
                    Text("Neu hier?")
                    NavigationLink(destination: RegistrationView()) {
                        Text("Erstelle dir dein Konto")
                    }
                }
            }
          
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
// Probleme durch das verschachteln durch die VStacks kam es dazu dass der VStack der RegistrationView nicht sichtbar war
