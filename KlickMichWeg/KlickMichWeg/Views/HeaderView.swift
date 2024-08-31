//
//  HeaderView.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let image: String
    var body: some View {
         VStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 300)
                .clipped()
                .shadow(color: .black, radius: 10, x: 5, y: 5)
            
            Text(title)
                .font(Font.custom("Arial", size: 20))
                .foregroundColor(.blue)
                .padding(.top, 20)
        }
    }
}
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", image:"Login")
    }
}

