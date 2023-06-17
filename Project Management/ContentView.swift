import SwiftUI

struct ContentView: View {
	@StateObject var vm = ContentViewModel()
	
	@State private var selectedLink: SidebarItem? = .home
	@State private var selectedSection: SectionEntity?
	@State private var selectedList: ListEntity?
	
	@State private var sectionName: String = ""
	
	@State private var showNewTask: Bool = false
	@State private var showNewList: Bool = false
	
	@State private var editList: Bool = false
	
	var body: some View {
#if os(iOS)
		if(UIDevice.isPhone) {
			TabView {
				Home()
					.tabItem {
						Label("Home", systemImage: "house")
					}
				Home()
					.tabItem {
						Label("Inbox", systemImage: "bell")
					}
				Home()
					.tabItem {
						Label("Search", systemImage: "magnifyingglass")
					}
				Home()
					.tabItem {
						Label("Account", systemImage: "person")
					}
			}
		} else {
			NavigationSplitView {
				SidebarListView(selectedLink: $selectedSection)
			} content: {
				if selectedSection != nil {
					ContentListView(selectedSection: selectedSection!, selectedList: $selectedList)
				} else {
					Text("Select a section")
				}
			} detail: {
				if let list = selectedList {
					ListDetailView(list: list)
				} else {
					
					Text("Select a list")
				}
			}
		}
#endif
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
