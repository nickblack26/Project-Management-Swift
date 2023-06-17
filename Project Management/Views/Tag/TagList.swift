//
//  TagList.swift
//  Project Management
//
//  Created by Nick on 12/16/22.
//

import SwiftUI

struct TagList: View {
    @StateObject private var vm = CoreDataViewModel()
    
    let task: TaskEntity
    
    var body: some View {
        List {
            if let taskTags = task.tags?.allObjects as? [TagEntity] {
                Section {
                    ForEach(taskTags, id: \.self) { tag in
                        HStack {
                            Text(tag.title!)
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            
            Section {
                ForEach(vm.tags, id: \.self) { tag in
                    if(!task.tags!.contains(tag)) {
                        Text(tag.title!)
                    }
                }
            }
        }
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        TagList(task: CoreDataViewModel().tasks[0])
    }
}
