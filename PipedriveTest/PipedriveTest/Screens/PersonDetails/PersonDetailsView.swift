//
//  PersonDetailsView.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 27.01.2025.
//

import SwiftUI

struct PersonDetailsView: View {
    @Environment(\.openURL) var openURL
    
    var person: Person
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 16) {
                picturesView
                Text(person.firstName)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Text(person.lastName)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                if person.organizationDataAvailable {
                    organizationView
                }
                if person.contactDataAvaialble {
                    contactsView
                }
            }
        }
    }
    
    var picturesView: some View {
        let urls = person.picture.allPictures().compactMap({ URL(string: $0)})
        guard !urls.isEmpty else {
            return EmptyView()
        }
        return PicturesView(urls: urls)
    }
    
    var organizationView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Organization")
            if !person.organizationName.isEmpty {
                Text(person.organizationName)
                    .font(.title)
            }
            if !person.ownerName.isEmpty {
                Text(person.ownerName)
                    .font(.subheadline)
            }
            if !person.ccEmail.isEmpty {
                ContactView(contact: ContactData(value: person.ccEmail, primary: false, label: ""), type: .email)
                    .onTapGesture {
                        openUrl(urlString: "\(ContactType.email.urlString)\(person.ccEmail)", openUrl: openURL)
                    }
            }
        }
        .groupedView()
    }
    
    var contactsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Contacts")
            ForEach(person.phones, id: \.value) { phone in
                ContactView(contact: phone, type: .phone)
                    .onTapGesture {
                        openUrl(urlString: "\(ContactType.phone.urlString)\(phone.value)", openUrl: openURL)
                    }
            }
            ForEach(person.emails, id: \.value) { email in
                ContactView(contact: email, type: .email)
                    .onTapGesture {
                        openUrl(urlString: "\(ContactType.email.urlString)\(email.value)", openUrl: openURL)
                    }
            }
        }
        .groupedView()
    }
    
    func openUrl(urlString: String, openUrl: OpenURLAction) {
        guard let url = URL(string: urlString) else { return }
        openUrl(url) { accepted in
            if !accepted {
                print("Failed, maybe it should be handled, for example creating alert")
            }
        }
    }
}

#Preview {
    PersonDetailsView(person: Person.empty())
}
