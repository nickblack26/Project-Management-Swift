//
//  HomeHeader.swift
//  Project Management
//
//  Created by Nick on 12/19/22.
//

import SwiftUI

struct HomeHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                Text("Today")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            Image("ProfileImage")
                .resizable()
                .frame(width: 50, height: 50)
                .scaledToFit()
                .cornerRadius(50)
        }
        .padding()
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader()
    }
}
