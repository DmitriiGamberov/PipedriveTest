//
//  Person.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 27.01.2025.
//

struct Picture: Codable, Hashable {
    let pictures: [String: String]
    
    func first() -> String? {
        guard let firstKey = pictures.keys.first else { return nil }
        return pictures[firstKey]
    }
    
    func allPictures() -> [String] {
        return Array(pictures.values)
    }
}

struct ContactData: Codable, Hashable {
    let value: String
    let primary: Bool
    let label: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decodeIfPresent(String.self, forKey: .value) ?? ""
        self.primary = try container.decodeIfPresent(Bool.self, forKey: .primary) ?? false
        self.label = try container.decodeIfPresent(String.self, forKey: .label) ?? ""
    }
    
    init(value: String, primary: Bool, label: String) {
        self.value = value
        self.primary = primary
        self.label = label
    }
}

struct Person: Codable, Identifiable, Equatable, Hashable {
    
    let id: Int
    let name: String
    let firstName: String
    let lastName: String
    let organizationName: String
    let ownerName: String
    let ccEmail: String
    let picture: Picture
    
    let phone: [ContactData?]?
    let email: [ContactData?]?
    
    var phones: [ContactData] {
        phone?.compactMap({ $0 }) ?? []
    }
    
    var emails: [ContactData] {
        email?.compactMap({ $0 }) ?? []
    }
    
    var organizationDataAvailable: Bool {
        !organizationName.isEmpty || !ownerName.isEmpty || !ccEmail.isEmpty
    }
    
    var contactDataAvaialble: Bool {
        !phones.isEmpty || !emails.isEmpty
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        self.organizationName = try container.decodeIfPresent(String.self, forKey: .organizationName) ?? ""
        self.ownerName = try container.decodeIfPresent(String.self, forKey: .ownerName) ?? ""
        self.ccEmail = try container.decodeIfPresent(String.self, forKey: .ccEmail) ?? ""
        self.picture = try container.decodeIfPresent(Picture.self, forKey: .picture) ?? Picture(pictures: [:])
        self.phone = try container.decodeIfPresent([ContactData?].self, forKey: .phone) ?? []
        self.email = try container.decodeIfPresent([ContactData?].self, forKey: .email) ?? []
    }
    
    init(id: Int, name: String, firstName: String, lastName: String, organizationName: String, ownerName: String, ccEmail: String, picture: Picture, phone: [ContactData?], email: [ContactData?]) {
        self.id = id
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.organizationName = organizationName
        self.ownerName = ownerName
        self.ccEmail = ccEmail
        self.picture = picture
        self.phone = phone
        self.email = email
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: Examples for preview
extension Person {
    static func regular() -> Person {
        Person(id: 1, name: "Name Lastname", firstName: "Name", lastName: "LastName", organizationName: "OrganizationName", ownerName: "Owner", ccEmail: "ccEmail", picture: Picture(pictures: ["1":"https://media.istockphoto.com/id/1316134499/photo/a-concept-image-of-a-magnifying-glass-on-blue-background-with-a-word-example-zoom-inside-the.jpg?s=1024x1024&w=is&k=20&c=b5kopTcDYozVMCDGVIDd4BUDI2zgxhSzKXPC2YBBIKc=", "2": "https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg"]), phone: [ContactData(value: "12345", primary: true, label: "Person")], email: [ContactData(value: "work@work.com", primary: true, label: "Work")])
    }
    
    static func longNameAndFailImage() -> Person {
        Person(id: 2, name: "Name Verylongnameofsomepersontohandle", firstName: "Name", lastName: "LastName", organizationName: "VeryLongOrganizationNameToHandleItNormally OÜ", ownerName: "Owner", ccEmail: "ccEmail", picture: Picture(pictures: ["123":"https://pipedrive-profile-pics.s3.example.com/f8893852574273f2747bf6ef09d11cfb4ac8f269_512.jpg"]), phone: [], email: [])
    }
    static func empty() -> Person {
        Person(id: 3, name: "", firstName: "", lastName: "", organizationName: "", ownerName: "", ccEmail: "", picture: Picture(pictures: [:]), phone: [], email: [])
    }
}
