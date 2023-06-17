//
//  EditList.swift
//  Project Management
//
//  Created by Nick on 12/21/22.
//

import SwiftUI

struct EditList: View {
    
    @ObservedObject var vm: EditListViewModel

    init(list: ListEntity) {
        self.vm = EditListViewModel(list: list)
    }
    
    var body: some View {
        Form {
            TextField("List Title", text: $vm.title)
            TextField("Description", text: $vm.description)
        }
    }
}

struct EditList_Previews: PreviewProvider {
    static var previews: some View {
        if let lists = ContentViewModel().sections[0].lists?.allObjects as? [ListEntity] {
            EditList(list: lists[0])
        }
    }
}
