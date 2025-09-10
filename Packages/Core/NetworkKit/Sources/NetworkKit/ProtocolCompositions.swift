//
//  ProtocolCompositions.swift
//  NetworkKit
//
//  Created by Batuhan Baran on 3.07.2025.
//

import Foundation

// MARK: - Protocol Compositions
public typealias APIModel = Codable & Sendable
public typealias NetworkModel = APIModel & Identifiable & Equatable & Hashable
