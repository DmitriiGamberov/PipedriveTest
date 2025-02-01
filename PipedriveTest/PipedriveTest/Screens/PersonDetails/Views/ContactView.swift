//
//  ContactView.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 01.02.2025.
//

import SwiftUI

enum ContactType {
    case phone
    case email
    
    var image: Image {
        switch self {
        case .phone:
            Image(systemName: "phone.fill")
        case .email:
            Image(systemName: "envelope")
        }
    }
    
    var urlString: String {
        switch self {
        case .phone:
            "tel:"
        case .email:
            "mailto:"
        }
    }
}

struct ContactView: View {
    let contact: ContactData
    let type: ContactType
    
    var body: some View {
        HStack {
            type.image
            Text(contact.value)
            Spacer()
            if contact.primary {
                Image(systemName: "star.fill")
            }
        }
        .foregroundStyle(Color.accentColor)
    }
}
