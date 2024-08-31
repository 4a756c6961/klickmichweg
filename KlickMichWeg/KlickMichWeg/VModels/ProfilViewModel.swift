//  ProfilViewModel.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

class ProfilViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var profilImage: UIImage? = nil
    @Published var profilImageURL: String? = nil
    
    init() {
      
    }
    
    // MARK: Funktionen Datenbank
    func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let database = Firestore.firestore()
        database.collection("users").document(userID).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                    
                )
                
                
                self?.fetchProfilImage()
        
            }
        }
    }
    
    // Upload ProfilImage
    func uploadProfilImage(_ image: UIImage) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let storage = Storage.storage().reference()
        let profilImageFolder = storage.child("users/\(userID)/profilImage")
        let profilImageRef = profilImageFolder.child("profilImage\(userID).png")
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        print("imageData size: \(imageData.count) bytes")
        
        profilImageRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            if let error = error {
                print("Ups, beim Upload ist ein Fehler passiert 🤯 \(error.localizedDescription)")
                return
            }
            
            profilImageRef.downloadURL { [weak self] url, error in
                if let error = error {
                    print("Ups, beim Download ist ein Fehler passiert 🤯 \(error.localizedDescription)")
                    return
                }
                self?.profilImageURL = url?.absoluteString
                
            }
        }
    }
    
    // funktion zu download der Bilder aus der Firestore Storage
    func fetchProfilImage() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let storage = Storage.storage().reference()
        let profilImageRef = storage.child("users/\(userID)/profilImage/profilImage\(userID).png")
        
        profilImageRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] data, error in
            if let error = error {
                print("Ups, beim Abrufen des Bildes ist ein Fehler passiert 🤯 \(error.localizedDescription)")
                return
            }
            
            if let imageData = data {
                DispatchQueue.main.async {
                    self?.profilImage = UIImage(data: imageData)
                }
            }
        }
    }
    
    // Löschfunktion des Bildes
    
    func deleteProfilImage() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let storage = Storage.storage().reference()
        let profilImageRef = storage.child("users/\(userID)/profilImage/profilImage\(userID).png")
        
        profilImageRef.delete { [weak self] error in
            if let deleteError = error {
                print("Beim löschen des Profilbildes ist ein Fehler passiert: \(deleteError.localizedDescription)")
                return
            }
            
            print("Dein Bild wurde erfolgreich gelöscht")
            
            // Also, you might want to update the profilImageURL and profilImage properties to nil
            self?.profilImageURL = nil
            self?.profilImage = nil
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
  

    

