//
//  ContentListView.swift
//  Project Management
//
//  Created by Nick on 5/31/23.
//

import SwiftUI
import CoreData

struct ContentListView: View {
//    @StateObject private var vm: ContentListViewModel
    @State private var createList: Bool = false
    var selectedSection: SectionEntity
    @Binding var selectedList: ListEntity?
	@Environment(\.managedObjectContext) var managedObjectContext
	@FetchRequest var lists: FetchedResults<ListEntity>
    
    init(selectedSection: SectionEntity, selectedList: Binding<ListEntity?>) {
		let request: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \ListEntity.order, ascending: true)]
		request.predicate = NSPredicate(format: "section.id == %@", selectedSection.id! as CVarArg)
        self.selectedSection = selectedSection
		self._lists = FetchRequest(fetchRequest: request)

//        self._vm = StateObject(wrappedValue: ContentListViewModel(lists: lists, selectedSection: selectedSection))
        self._selectedList = selectedList
    }
    
    var body: some View {
        List(selection: $selectedList) {
            Section("Lists") {
				ForEach(lists.indices, id: \.self) { index in
					NavigationLink(value: lists[index]) {
                        HStack {
                            Text(lists[index].name ?? "No name")
                            Text("\(lists[index].order)")
							Text("\(index)")
                        }
                        
                    }
                }
//                .onMove(perform: vm.reorder)
//                .onDelete(perform: vm.removeRows)
            }
            .headerProminence(.increased)
        }
        .navigationTitle(selectedSection.name ?? "Section")
        .toolbar {
            ToolbarItem {
                EditButton()
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    createList.toggle()
                } label: {
                    Text("Add List")
                }
            }
        }
        .sheet(isPresented: $createList, content: {
            NavigationStack {
                NewListView(section: selectedSection)
            }
        })
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
