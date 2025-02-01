//
//  PersonRow.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 27.01.2025.
//

import SwiftUI

struct PersonRow: View {
    var person: Person
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if let avatar = person.picture.first() {
                AsyncImage(url: URL(string: avatar)) { phase in
                    if let image = phase.image {            image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                    } else if phase.error != nil {
                        Image(systemName: "person.circle")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(Color.red)
                            .frame(width: 50, height: 50)
                    } else {
                        if person.picture.first() != nil {
                            ProgressView()
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
            }

            VStack {
                Text(person.name)
                    .font(.headline)
                Text(person.organizationName)
                    .font(.subheadline)
                
            }
            Spacer()
            Image(systemName: "info.circle")
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

#Preview {
    Group {
        PersonRow(person: Person.regular())
        PersonRow(person: Person.longNameAndFailImage())
        PersonRow(person: Person.empty())
    }

}
