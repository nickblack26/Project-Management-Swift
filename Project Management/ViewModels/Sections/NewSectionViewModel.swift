//
//  NewSectionViewModel.swift
//  Project Management
//
//  Created by Nick on 5/31/23.
//

import Foundation

class NewSectionViewModel: ObservableObject {
    @Published var name: String = ""
    let manager = CoreDataManager.shared
    
    func createList() {
        let section = SectionEntity(context: manager.context)
        section.id = UUID()
        section.name = self.name
        manager.saveData()
    }
}
