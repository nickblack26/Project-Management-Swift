//
//  ListDetailViewModel.swift
//  Project Management
//
//  Created by Nick on 12/21/22.
//

import Foundation
import SwiftUI

class ListDetailViewModel: ObservableObject {
    @Published var title: String
    @Published var color: Color
    @Published var description: String
    @Published var section: SectionEntity
    @Published var date: Date
    
    var listContext: ListEntity? = nil
    
    let manager = CoreDataManager.shared
    
    init(list: ListEntity? = nil) {
        self.listContext = list ?? nil
        self.title = list?.name ?? ""
        self.description = ""
        self.color = .blue
        self.section = (list?.section)!
        self.date = Date()
    }
    
    func updateList() {
        listContext?.name = self.title
        manager.saveData()
    }
}
