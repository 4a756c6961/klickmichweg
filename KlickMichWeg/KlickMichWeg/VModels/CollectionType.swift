//
//  CollectionType.swift
//  KlickMichWeg
//
//  Created by Julia on 03.08.24.
//
enum CollectionType: String, CaseIterable, Identifiable {
    case workToDos = "workToDos"
    case homeToDos = "homeToDos"
    case studyToDos = "studyToDos"

    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .workToDos:
            return "Job"
        case .homeToDos:
            return "Freizeit"
        case .studyToDos:
            return "Studium"
        }
    }
}
