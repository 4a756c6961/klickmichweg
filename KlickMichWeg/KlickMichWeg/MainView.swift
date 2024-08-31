//
//  ContentView.swift
//  KlickMichWeg
//
//  Created by Julia on 22.06.24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserID.isEmpty {
          kontoView
            } else {
                LoginView()
            }
            
        }
    
    @ViewBuilder
    var kontoView: some View {
        TabView {
            ToDoListView(userID:viewModel.currentUserID)
                .tabItem {
                    Label("Job", image: "job")
                }
            HomeView(userID: viewModel.currentUserID)
                .tabItem {
                    Label("Freizeit", image: "Home")
                }
            StudyView(userID: viewModel.currentUserID)
                .tabItem {
                    Label("Studium", image: "edu")
                }
            ProfilView()
                .tabItem{
                    Label("Profil", image: "profil")
                }
        }
        
    }
    }

#Preview {
    MainView()
}
