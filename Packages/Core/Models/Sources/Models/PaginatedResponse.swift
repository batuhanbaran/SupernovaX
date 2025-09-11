//
//  PaginatedResponse.swift
//  Models
//
//  Created by Batuhan Baran on 11.09.2025.
//

import Foundation

@available(iOS 13.0, *)
public protocol PaginatedResponse: CodableModel {
    associatedtype Item: Identifiable & Sendable
    var total: Int { get }
    var items: [Item] { get }
}