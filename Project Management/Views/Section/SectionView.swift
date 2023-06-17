import SwiftUI

struct SectionView: View {
    private var tabs = ["Discussion", "Lists", "Overview"]
    @State private var selectedTab: String? = "Discussion"
    @State private var message: String = ""
    @State private var data: Int = 50
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
//                ForEach(0..<tabs.count) { index in
//                    SectionTabView(title: tabs[index], isActive: tabs[index] == selectedTab ? true : false)
//                        .onTapGesture {
//                            selectedTab = tabs[index]
//                        }
//                }
                Spacer()
            }
            .padding()
            
            Divider()
            
            ScrollViewReader { proxy in
                            List {
                                ForEach(0..<data, id: \.self) { datum in
                                    Text("\(datum)")
                                        .id(datum)
                                }
//                                .onDelete {
//                                    data.remove(atOffsets: $0)
//                                }

                            }
//                            .onChange(of: data) { _ in
//                                proxy.scrollTo(data.last)
//                            }
                        }
        }
        .navigationTitle("Section Name")
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SectionView()
        }
    }
}
