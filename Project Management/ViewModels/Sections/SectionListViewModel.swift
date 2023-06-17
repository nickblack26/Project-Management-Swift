//
//  SectionListings.swift
//  Project Management
//
//  Created by Nick on 12/21/22.
//

import Foundation
import SwiftUI

class SectionListViewModel: ObservableObject {
    @Published var lists: [ListEntity] = []
    @Published var selectedList: ListEntity?
    @Published var sectionContext: SectionEntity
    
    let manager = CoreDataManager.shared
        
    init(section: SectionEntity) {
        self.sectionContext = section
        if let lists = section.lists?.allObjects as? [ListEntity] {
            self.lists = lists
            self.selectedList = lists[0]
        }
    }
    
    func createList(title: String, color: Color, section: SectionEntity? = nil) {
        let newList = ListEntity(context: manager.context)
        newList.name = title
        if(section == nil) {
            newList.section = sectionContext
        } else {
            newList.section = section
        }
    }
    
    func removeList(list: ListEntity) {
        manager.context.delete(list)
        manager.saveData()
    }
}
