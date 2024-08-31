//
//  ListItems.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import Foundation

struct ListItems: Codable, Identifiable {
    var id: String
    var title: String
    var date: TimeInterval
    var createdDate: TimeInterval
    var notiz: String
    var isDone: Bool
    
    mutating func setDone(_ state:Bool) {
        isDone = state
    }
}
