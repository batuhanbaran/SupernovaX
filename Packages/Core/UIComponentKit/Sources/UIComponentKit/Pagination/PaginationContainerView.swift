//
//  PaginationContainerView.swift
//  DummyUser
//
//  Created by Batuhan BARAN on 4.06.2025.
//

import Factory
import SwiftUI
import Models
import NetworkKit
import ExtensionsKit

@available(iOS 13.0, *)
public protocol PaginatedResponse: CodableModel {
    associatedtype Item: Identifiable & Sendable
    var total: Int { get }
    var items: [Item] { get }
}

public struct PaginationContainerView<
    RowView: View,
    Element: Identifiable & Sendable,
    Response: PaginatedResponse
>: View where Response.Item == Element {

    @Binding var items: [Element]
    let path: String
    let responseType: Response.Type
    var axis: Axis.Set = .vertical
    let rowView: (Element) -> RowView
    let initialTotal: Int

    public init(
        items: Binding<[Element]>,
        path: String,
        responseType: Response.Type,
        total: Int = 0,
        axis: Axis.Set = .vertical,
        @ViewBuilder rowView: @escaping (Element) -> RowView
    ) {
        self._items = items
        self.path = path
        self.responseType = responseType
        self.initialTotal = total
        self.axis = axis
        self.rowView = rowView
    }

    @Injected(\.paginationService)
    private var service

    @State private var skip: Int = 0
    @State private var total: Int = 0
    private let limit: Int = 20

    public var body: some View {
        ScrollView(
            axis,
            showsIndicators: axis.contains(.vertical)
        ) {
            contentForAxis
        }
        .onAppear {
            if total == 0 && initialTotal > 0 {
                total = initialTotal
                skip = items.count
            }
        }
    }

    private var contentForAxis: some View {
        Group {
            if axis == .horizontal {
                LazyHStack {
                    itemRows
                }
            } else {
                LazyVStack {
                    itemRows
                }
            }
        }
    }

    private var itemRows: some View {
        ForEach(items, id: \.id) { item in
            rowView(item)
                .onAppear {
                    Task {
                        if items.isLastItem(item) && items.count < total && total > 0 {
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
        var endpoint = DefaultPaginationEndpoint<Response>(total: total, path: path)
        endpoint.limit = limit
        endpoint.skip = skip

        if let response = await service.fetch(endpoint) {
            let newItems = response.items

            if total == 0 {
                total = response.total
                skip = items.count + newItems.count
            } else {
                skip += limit
            }

            items.append(contentsOf: newItems)
        }
    }
}
