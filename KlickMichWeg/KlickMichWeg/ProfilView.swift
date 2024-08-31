//
//  ProfilView.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import SwiftUI


struct ProfilView: View {
    @StateObject var viewModel = ProfilViewModel()
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    //An der Stelle wird das Bild aus der Datenbank agezeigt oder wenn keins da ist das SystemImage
                    
                    if let profilImage = viewModel.profilImage {
                        Image(uiImage:profilImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125, height: 125)
                            .padding()
                    }
                    
                    else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                        .frame(width: 125, height: 125)
                        .padding()
                }
                    
                    // Button zum Profilbild wechsel dieser wird zum Imagepicker
                    Button("Profilbild ändern") {
                        showImagePicker = true
                    }
                    .sheet (isPresented: $showImagePicker) {
                        ImagePicker(image: $selectedImage)
                    }
                    .onChange(of: selectedImage) {
                        newValue in
                        if let image = newValue {
                            viewModel.uploadProfilImage(image)
                        }
                    }
                    
                    //Button zum Löschen des Profilbildes
                    
                    Button(action: {
                        viewModel.deleteProfilImage()
                        
                    }) {
                        Label("", systemImage: "trash.fill")
                    }
                                     
                    
                    
                    // Info zum User
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Name: ")
                                .bold()
                            Text(user.name)
                        }
                        HStack {
                            Text("E-Mail: ")
                                .bold()
                            Text(user.email)
                        }
                        
                        HStack {
                            Text("angemeldet seit: ")
                                .bold()
                            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .standard))")
                        }
                        
                    }
                    .padding()
                    //Logout
                    CustomButton(title: "Logout", background: .red) {
                        viewModel.logOut()
                    }
                    .frame(width: 200, height: 100)
                    .padding()
                    Spacer()
                } else {
                    Text("Profil wird geladen ...")
                }
            }
           .navigationTitle("Profil")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
}

#Preview {
    ProfilView()
}
