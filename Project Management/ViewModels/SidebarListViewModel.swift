import Foundation
import CoreData

class SidebarListViewModel: ObservableObject {
    @Published var sections: [SectionEntity] = []
    
    let manager = CoreDataManager.shared
    
    init() {
        self.fetchSections()
    }
    
    func fetchSections() {
        let sectionRequest = NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
        sectionRequest.predicate = NSPredicate(format: "name != %@ AND favorite = %@", "Everything", NSNumber(value: false))
		let sectionSort = NSSortDescriptor(key: "order", ascending: true)
//		let listSort = NSSortDescriptor(key: "lists.order", ascending: true)
		sectionRequest.sortDescriptors = [sectionSort]
        let defaultSectionsRequest = NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
        defaultSectionsRequest.predicate = NSPredicate(format: "name == %@", "Everything")
        let favoriteSectionsRequest = NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
        favoriteSectionsRequest.predicate = NSPredicate(format: "favorite = %@", NSNumber(value: true))
        
        do {
            let data = try manager.context.fetch(sectionRequest)
            self.sections = data
            //            if !self.sections.isEmpty {
            //                deleteSection(section: self.sections[0])
            //            }
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func createSection(title: String) {
        let newSection = SectionEntity(context: manager.context)
        newSection.name = title
        newSection.id = UUID()
        manager.saveData()
        createList(title: "List", section: newSection)
        fetchSections()
    }
    
    func createList(title: String, section: SectionEntity?) {
        let newList = ListEntity(context: manager.context)
        newList.name = title
        newList.id = UUID()
        if(section != nil) {
            newList.section = section
        }
        manager.saveData()
        fetchSections()
    }
    
    func removeRows(at offsets: IndexSet) {
        for offset in offsets {
            manager.context.delete(self.sections[offset])
        }
        manager.saveData()
        fetchSections()
    }
    
    func reorderSection(from: IndexSet, to: Int) {
        for offset in from {
            self.sections[offset].order = Int16(to)
        }
        manager.saveData()
        
        self.sections.move(fromOffsets: from, toOffset: to)
        
    }
    
}
