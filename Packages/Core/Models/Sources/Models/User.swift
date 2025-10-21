//
//  User.swift
//  Models
//
//  Created by Batuhan BARAN on 2.06.2025.
//

import Foundation

// MARK: - User Model
public struct User: StandardModel {
    @SafeOptionalDecode public var id: Int?
    @SafeOptionalDecode public var firstName: String?
    @SafeOptionalDecode public var lastName: String?
    @SafeOptionalDecode public var maidenName: String?
    @SafeOptionalDecode public var age: Int?
    @SafeOptionalDecode public var gender: String?
    @SafeOptionalDecode public var email: String?
    @SafeOptionalDecode public var phone: String?
    @SafeOptionalDecode public var username: String?
    @SafeOptionalDecode public var password: String?
    @SafeOptionalDecode public var birthDate: String?
    @SafeOptionalDecode public var image: String?
    @SafeOptionalDecode public var bloodGroup: String?
    @SafeOptionalDecode public var height: Double?
    @SafeOptionalDecode public var weight: Double?
    @SafeOptionalDecode public var eyeColor: String?
    @SafeOptionalDecode public var hair: Hair?
    @SafeOptionalDecode public var ip: String?
    @SafeOptionalDecode public var address: Address?
    @SafeOptionalDecode public var macAddress: String?
    @SafeOptionalDecode public var university: String?
    @SafeOptionalDecode public var bank: Bank?
    @SafeOptionalDecode public var company: Company?
    
    public init(
        id: Int? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        maidenName: String? = nil,
        age: Int? = nil,
        gender: String? = nil,
        email: String? = nil,
        phone: String? = nil,
        username: String? = nil,
        password: String? = nil,
        birthDate: String? = nil,
        image: String? = nil,
        bloodGroup: String? = nil,
        height: Double? = nil,
        weight: Double? = nil,
        eyeColor: String? = nil,
        hair: Hair? = nil,
        ip: String? = nil,
        address: Address? = nil,
        macAddress: String? = nil,
        university: String? = nil,
        bank: Bank? = nil,
        company: Company? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.maidenName = maidenName
        self.age = age
        self.gender = gender
        self.email = email
        self.phone = phone
        self.username = username
        self.password = password
        self.birthDate = birthDate
        self.image = image
        self.bloodGroup = bloodGroup
        self.height = height
        self.weight = weight
        self.eyeColor = eyeColor
        self.hair = hair
        self.ip = ip
        self.address = address
        self.macAddress = macAddress
        self.university = university
        self.bank = bank
        self.company = company
    }
}

// MARK: - Address Model
public struct Address: StandardModel {
    @SafeOptionalDecode public var address: String?
    @SafeOptionalDecode public var city: String?
    @SafeOptionalDecode public var state: String?
    @SafeOptionalDecode public var stateCode: String?
    @SafeOptionalDecode public var postalCode: String?
    @SafeOptionalDecode public var coordinates: Coordinates?
    @SafeOptionalDecode public var country: String?
    
    // Required for Identifiable - using address as identifier
    public var id: String {
        return "\(address ?? "")_\(city ?? "")_\(postalCode ?? "")"
    }
    
    public init(
        address: String? = nil,
        city: String? = nil,
        state: String? = nil,
        stateCode: String? = nil,
        postalCode: String? = nil,
        coordinates: Coordinates? = nil,
        country: String? = nil
    ) {
        self.address = address
        self.city = city
        self.state = state
        self.stateCode = stateCode
        self.postalCode = postalCode
        self.coordinates = coordinates
        self.country = country
    }
}

// MARK: - Coordinates Model
public struct Coordinates: StandardModel {
    @SafeOptionalDecode public var lat: Double?
    @SafeOptionalDecode public var lng: Double?
    
    // Required for Identifiable - using coordinates as identifier
    public var id: String {
        return "\(lat ?? 0.0)_\(lng ?? 0.0)"
    }
    
    public init(lat: Double? = nil, lng: Double? = nil) {
        self.lat = lat
        self.lng = lng
    }
}

// MARK: - Bank Model
public struct Bank: StandardModel {
    @SafeOptionalDecode public var cardExpire: String?
    @SafeOptionalDecode public var cardNumber: String?
    @SafeOptionalDecode public var cardType: String?
    @SafeOptionalDecode public var currency: String?
    @SafeOptionalDecode public var iban: String?
    
    // Required for Identifiable - using iban or cardNumber as identifier
    public var id: String {
        return iban ?? cardNumber ?? UUID().uuidString
    }
    
    public init(
        cardExpire: String? = nil,
        cardNumber: String? = nil,
        cardType: String? = nil,
        currency: String? = nil,
        iban: String? = nil
    ) {
        self.cardExpire = cardExpire
        self.cardNumber = cardNumber
        self.cardType = cardType
        self.currency = currency
        self.iban = iban
    }
}

// MARK: - Company Model
public struct Company: StandardModel {
    @SafeOptionalDecode public var department: String?
    @SafeOptionalDecode public var name: String?
    @SafeOptionalDecode public var title: String?
    @SafeOptionalDecode public var address: Address?
    
    // Required for Identifiable - using name as identifier
    public var id: String {
        return name ?? UUID().uuidString
    }
    
    public init(
        department: String? = nil,
        name: String? = nil,
        title: String? = nil,
        address: Address? = nil
    ) {
        self.department = department
        self.name = name
        self.title = title
        self.address = address
    }
}

// MARK: - Hair Model
public struct Hair: StandardModel {
    @SafeOptionalDecode public var color: String?
    @SafeOptionalDecode public var type: String?
    
    // Required for Identifiable - using color and type as identifier
    public var id: String {
        return "\(color ?? "")_\(type ?? "")"
    }
    
    public init(color: String? = nil, type: String? = nil) {
        self.color = color
        self.type = type
    }
}

public extension User {
    static let mock = User(
        id: 1,
        firstName: "Batuhan",
        lastName: "Baran",
        maidenName: "Test",
        age: 28,
        gender: "male",
        email: "batuhan@example.com",
        phone: "+90 555 555 55 55",
        username: "batuhanbaran",
        password: "password123",
        birthDate: "1997-01-01",
        image: "https://randomuser.me/api/portraits/men/1.jpg",
        bloodGroup: "O+",
        height: 178.0,
        weight: 75.0,
        eyeColor: "brown",
        hair: Hair(color: "black", type: "wavy"),
        ip: "192.168.1.1",
        address: Address(
            address: "123 Example St",
            city: "Ankara",
            state: "Çankaya",
            stateCode: "06",
            postalCode: "06510",
            coordinates: Coordinates(lat: 39.9208, lng: 32.8541),
            country: "Turkey"
        ),
        macAddress: "00:1B:44:11:3A:B7",
        university: "Atılım University",
        bank: Bank(
            cardExpire: "12/25",
            cardNumber: "1234-5678-9012-3456",
            cardType: "Visa",
            currency: "TRY",
            iban: "TR320010009999901234567890"
        ),
        company: Company(
            department: "iOS Development",
            name: "Appcent",
            title: "Senior iOS Developer",
            address: Address(
                address: "Company Address",
                city: "Istanbul",
                state: "Kadıköy",
                stateCode: "34",
                postalCode: "34710",
                coordinates: Coordinates(lat: 40.9919, lng: 29.1236),
                country: "Turkey"
            )
        )
    )
}
