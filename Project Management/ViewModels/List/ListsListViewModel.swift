//
//  ListsListViewModel.swift
//  Project Management
//
//  Created by Nick on 5/31/23.
//

import Foundation
import CoreData

class ListsListViewModel: ObservableObject {
    @Published var lists: [ListEntity] = []
    let manager = CoreDataManager.shared
    
    init() {
        fetchLists()
    }
    
    func fetchLists() {
        let listsRequest = NSFetchRequest<ListEntity>(entityName: "ListEntity")
        do {
            self.lists = try manager.context.fetch(listsRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        for offset in offsets {
            manager.context.delete(self.lists[offset])
        }
        manager.saveData()
        fetchLists()
    }
}
