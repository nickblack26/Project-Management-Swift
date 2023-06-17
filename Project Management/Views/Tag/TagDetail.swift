//
//  TagDetail.swift
//  Project Management
//
//  Created by Nick on 12/16/22.
//

import SwiftUI

struct TagDetail: View {
    let tag: TagEntity
    
    @State private var tagTitle: String
    
    init(tag: TagEntity) {
        self.tag = tag
        self._tagTitle = State<String>(initialValue: tag.title != nil ? tag.title! : "")
    }
    
    var body: some View {
        Form {
            Section(header: Text("General Information")) {
                TextField("Title", text: $tagTitle)
            }
            
            if let tasks = tag.tasks?.allObjects as? [TaskEntity] {
                Section(header: Text("Tasks")) {
                    List(tasks, id: \.self) { task in
                        Text(task.title ?? "")
                    }
                }
            }
        }
    }
}

struct TagDetail_Previews: PreviewProvider {
    static var previews: some View {
        TagDetail(tag: CoreDataViewModel().tags[0])
    }
}
