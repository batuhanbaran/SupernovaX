//
//  SegmentControlView.swift
//  UIComponentKit
//
//  Created by Batuhan Baran on 10.10.2025.
//

import SwiftUI

public protocol Segmentable: Equatable & Hashable & CustomStringConvertible & CaseIterable {
    var systemImageName: String? { get }
    var underlineColor: Color { get } 
}

public extension Segmentable {

    var systemImageName: String? { nil }
}

public struct SegmentControlView<Segment: Segmentable>: View {

    public enum Distribution {
        case fit
        case fillEqually
    }

    private let items: [Segment]
    @Binding var selectedSegment: Segment
    private let distribution: Distribution
    @Namespace private var underlineNamespace

    public init(items: [Segment], selectedSegment: Binding<Segment>, distribution: Distribution = .fit) {
        self.items = items
        self._selectedSegment = selectedSegment
        self.distribution = distribution
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                if distribution == .fillEqually {
                    HStack(spacing: 0) {
                        ForEach(items, id: \.self) { item in
                            segmentButton(for: item)
                                .frame(maxWidth: .infinity)
                                .id(item)
                        }
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(items, id: \.self) { item in
                                segmentButton(for: item)
                                    .id(item)
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                }
            }
            .padding(.top, 8)

            Divider()
        }
        .frame(height: 56)
    }

    @ViewBuilder
    private func segmentButton(for item: Segment) -> some View {
        Button {
            guard item != selectedSegment else { return }
            withAnimation(.easeInOut) {
                selectedSegment = item
            }
        } label: {
            HStack(spacing: 6) {
                Text(item.description)
                    .lineLimit(1)
                if let system = item.systemImageName {
                    Image(systemName: system)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(
            GeometryReader { geo in
                ZStack {
                    if item == selectedSegment {
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 2)
                                .frame(width: geo.size.width)
                                .foregroundColor(item.underlineColor)
                                .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                        }
                        .transition(.opacity)
                    }
                }
            }
        )
    }
}
