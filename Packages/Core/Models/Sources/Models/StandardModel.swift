//
//  StandardModel.swift
//  Models
//
//  Created by Batuhan BARAN on 24.06.2025.
//

import Foundation

public typealias CodableModel = Codable & Sendable
public typealias IdentifiableModel = Identifiable & Equatable & Hashable
public protocol StandardModel: CodableModel & IdentifiableModel {}

public extension StandardModel {
    var uuid: UUID {
        UUID()
    }
}
