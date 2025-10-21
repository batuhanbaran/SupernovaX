//
//  TokenError.swift
//  TokenKitLive
//
//  Created by Batuhan Baran on 2.10.2025.
//

import Foundation

enum TokenError: Error {
    case tokenNotFound
    case decodeFailed(underlying: Error)
    case saveFailed(underlying: Error)
    case deleteFailed(underlying: Error)

    var localizedDescription: String {
        switch self {
        case .tokenNotFound:
            return "Token bulunamadı"
        case .decodeFailed(let error):
            return "Token decode edilemedi: \(error.localizedDescription)"
        case .saveFailed(let error):
            return "Token kaydedilemedi: \(error.localizedDescription)"
        case .deleteFailed(let error):
            return "Token silinemedi: \(error.localizedDescription)"
        }
    }
}
