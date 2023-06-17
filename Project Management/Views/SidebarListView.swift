import SwiftUI

enum SidebarItem: Hashable {
	case home
	case inbox
	case tasks
	case section(SectionEntity)
	case list(ListEntity)
}

struct SidebarListView: View {
	@State private var createSection: Bool = false
	@Binding var selectedLink: SectionEntity?
	@Environment(\.managedObjectContext) var managedObjectContext
	@FetchRequest(
		sortDescriptors: [SortDescriptor(\.order)],
		predicate: NSPredicate(format: "name != %@ AND favorite = %@", "Everything", NSNumber(value: false))
	)
	private var sectionEntities: FetchedResults<SectionEntity>
	
	func removeRows(at offsets: IndexSet) {
		for index in offsets {
			let section = sectionEntities[index]
			managedObjectContext.delete(section)
		}
		
		try? managedObjectContext.save()
	}
	
	func reorderSection(from: IndexSet, to: Int) {
		for offset in from {
			sectionEntities[offset].order = Int16(to)
		}
		
		try? managedObjectContext.save()
		
		sectionEntities.nsSortDescriptors.move(fromOffsets: from, toOffset: to)
	}
	
	var body: some View {
		List(selection: $selectedLink) {
			Label("Home", systemImage: "house")
			
			Label("My Tasks", systemImage: "checkmark.circle")
			
			Label("Inbox", systemImage: "bell")
			
			
			Section("Sections") {
				ForEach(sectionEntities) { section in
					NavigationLink(value: section) {
						HStack {
							Label(section.name ?? "", systemImage: "circle")
								.lineLimit(1)
							
							Spacer()
							
							Button {
								
							} label: {
								Image(systemName: "info.circle")
							}
						}
					}
				}
				.onMove(perform: reorderSection)
				.onDelete(perform: removeRows)
			}
			
			Section("Manage") {
				Button("Notifications & Email") {
					createSection.toggle()
				}
				
			}
		}
		.toolbar {
			ToolbarItem {
				EditButton()
			}
			
			ToolbarItem(placement: .bottomBar) {
				Button {
					createSection.toggle()
				} label: {
					Text("Add Space")
				}
			}
		}
		.sheet(isPresented: $createSection, content: {
			NavigationStack {
				NewSectionView()
			}
		})
		.navigationTitle("Tasks")
	}
}

struct Sidebar_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
