//
//  PaginationContainerView.swift
//  SupernovaX
//
//  Created by Batuhan BARAN on 4.06.2025.
//

import Factory
import SwiftUI
import Models
import NetworkKit
import ExtensionsKit

public enum PaginationLayout {
    case list(Axis.Set = .vertical)
    case grid(columns: Int, spacing: CGFloat = 8)
    case adaptiveGrid(minItemWidth: CGFloat, spacing: CGFloat = 8)
}

public struct PaginationContainerView<
    RowView: View,
    Element: Identifiable & Sendable,
    Response: PaginatedResponse
>: View where Response.Item == Element {

    @Binding var items: [Element]
    let path: String
    let responseType: Response.Type
    let layout: PaginationLayout
    let rowView: (Element) -> RowView
    let total: Binding<Int>

    public init(
        items: Binding<[Element]>,
        path: String,
        responseType: Response.Type,
        total: Binding<Int>,
        layout: PaginationLayout = .list(),
        @ViewBuilder rowView: @escaping (Element) -> RowView
    ) {
        self._items = items
        self.path = path
        self.responseType = responseType
        self.total = total
        self.layout = layout
        self.rowView = rowView
    }

    // Backward compatibility initializer
    public init(
        items: Binding<[Element]>,
        path: String,
        responseType: Response.Type,
        total: Binding<Int>,
        axis: Axis.Set = .vertical,
        @ViewBuilder rowView: @escaping (Element) -> RowView
    ) {
        self.init(
            items: items,
            path: path,
            responseType: responseType,
            total: total,
            layout: .list(axis),
            rowView: rowView
        )
    }

    @Injected(\.paginationService)
    private var service

    @State private var skip: Int = 0
    private let limit: Int = 20

    public var body: some View {
        ScrollView(scrollAxis, showsIndicators: showsIndicators) {
            contentForLayout
        }
    }

    private var scrollAxis: Axis.Set {
        switch layout {
        case .list(let axis):
            return axis
        case .grid, .adaptiveGrid:
            return .vertical
        }
    }

    private var showsIndicators: Bool {
        switch layout {
        case .list(let axis):
            return axis.contains(.vertical)
        case .grid, .adaptiveGrid:
            return true
        }
    }

    @ViewBuilder
    private var contentForLayout: some View {
        switch layout {
        case .list(let axis):
            if axis == .horizontal {
                LazyHStack {
                    itemRows
                }
            } else {
                LazyVStack {
                    itemRows
                }
            }

        case .grid(let columns, let spacing):
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns),
                spacing: spacing
            ) {
                itemRows
            }

        case .adaptiveGrid(let minItemWidth, let spacing):
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: minItemWidth), spacing: spacing)],
                spacing: spacing
            ) {
                itemRows
            }
        }
    }

    private var itemRows: some View {
        ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
            rowView(item)
                .onAppear {
                    Task {
                        // Index tabanlı kontrol - en güvenli ve performanslı
                        if items.isLastItem(item), items.count < total.wrappedValue {
                            await loadMore()
                        }
                    }
                }
        }
    }

    func loadMore() async {
        await performLoad(with: responseType)
    }

    private func performLoad(with type: Response.Type) async {
        var endpoint = DefaultPaginationEndpoint<Response>(total: total.wrappedValue, path: path)
        endpoint.limit = limit
        endpoint.skip = skip

        if let response = await service.fetch(endpoint) {
            let newItems = response.items
            skip += limit

            items.append(contentsOf: newItems)
        }
    }
}
