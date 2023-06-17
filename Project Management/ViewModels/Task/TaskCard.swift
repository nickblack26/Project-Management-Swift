//
//  TaskCard.swift
//  Project Management
//
//  Created by Nick on 12/19/22.
//

import SwiftUI

struct TaskCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Team Party")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Make fun with team mates")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                Text(Date().formatted(date: .omitted, time: .shortened))
            }
        }
        .padding()
        .background(Color("Black"))
        .foregroundColor(.white)
        .cornerRadius(16)
    }
}

struct TaskCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskCard()
    }
}
