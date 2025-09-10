//
//  RandomAccessCollection.swift
//  ExtensionsKit
//
//  Created by Batuhan BARAN on 24.06.2025.
//

import Foundation

@available(iOS 13.0, *)
public extension RandomAccessCollection where Self.Element: Identifiable {
    func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard !isEmpty else {
            return false
        }

        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }

        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1
    }
}
