//
//  ContentListViewModel.swift
//  Project Management
//
//  Created by Nick on 5/31/23.
//

import Foundation
import CoreData

class ContentListViewModel: ObservableObject {
    @Published var lists: [ListEntity] = []
    var selectedSection: SectionEntity
    let manager = CoreDataManager.shared
    
    init(lists: [ListEntity], selectedSection: SectionEntity) {
        self.lists = lists
        self.selectedSection = selectedSection
		self.fetchLists()
    }
    
    func fetchLists() {
        let listsRequest = NSFetchRequest<ListEntity>(entityName: "ListEntity")
        listsRequest.predicate = NSPredicate(format: "section.id == %@", selectedSection.id! as CVarArg)
        let sort = NSSortDescriptor(key: "order", ascending: true)
        listsRequest.sortDescriptors = [sort]
        
        do {
            self.lists = try manager.context.fetch(listsRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        offsets.map{lists[$0]}.forEach(manager.context.delete)
//        for offset in offsets {
//            manager.context.delete(self.lists[offset])
//        }
        manager.saveData()
        fetchLists()
    }
    
    func reorder(from source: IndexSet, to destination: Int) {
        let itemToMove = source.first!
		
		print(itemToMove)
        
        if itemToMove < destination {
            var startIndex = itemToMove + 1
            let endIndex = destination + 1
			print("start \(startIndex) end \(endIndex)")
            var startOrder = self.lists[itemToMove].order
            while startIndex <= endIndex {
                self.lists[startIndex].order = startOrder
                startOrder+=1
                startIndex+=1
            }
            self.lists[itemToMove].order = startOrder
        } else if destination < itemToMove {
            var startIndex = destination
            let endIndex = itemToMove - 1
			print("start \(startIndex) end \(endIndex)")
            var startOrder = self.lists[destination].order + 1
            let newOrder = self.lists[destination].order + 1
            
			while startIndex <= endIndex {
                self.lists[startIndex].order = startOrder
                startOrder+=1
                startIndex+=1
            }
			
            self.lists[itemToMove].order = newOrder
        }
        self.lists.move(fromOffsets: source, toOffset: destination)
        manager.saveData()
		fetchLists()
    }
}
