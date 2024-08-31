//
//  User.swift
//  KlickMichWeg
//
//  Created by Julia on 23.06.24.
//

import Foundation
struct User: Encodable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
 }
