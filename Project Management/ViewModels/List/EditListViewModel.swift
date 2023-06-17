//
//  EditListViewModel.swift
//  Project Management
//
//  Created by Nick on 12/21/22.
//

import Foundation
import SwiftUI

class EditListViewModel: ObservableObject {
    @Published var title: String
    @Published var color: Color
    @Published var description: String
    
    var listContext: ListEntity
    
    init(list: ListEntity) {
        listContext = list
        self.title = list.name ?? ""
        self.color = .blue
        self.description = ""
    }
}
