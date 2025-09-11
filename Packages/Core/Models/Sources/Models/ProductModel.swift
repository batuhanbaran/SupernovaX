//
//  ProductModel.swift
//  Models
//
//  Created by Batuhan Baran on 11.09.2025.
//

import Foundation

// MARK: - Product
public struct ProductModel: StandardModel {
    public var id: Int?
    public var title: String?
    public var description: String?
    public var category: String?
    public var price: Double?
    public var discountPercentage: Double?
    public var rating: Double?
    public var stock: Int?
    public var tags: [String]?
    public var brand: String?
    public var sku: String?
    public var weight: Double?
    public var dimensions: Dimensions?
    public var warrantyInformation: String?
    public var shippingInformation: String?
    public var availabilityStatus: String?
    public var reviews: [Review]?
    public var returnPolicy: String?
    public var minimumOrderQuantity: Int?
    public var meta: Meta?
    public var thumbnail: String?
    public var images: [String]?

    public init(
        id: Int? = nil,
        title: String? = nil,
        description: String? = nil,
        category: String? = nil,
        price: Double? = nil,
        discountPercentage: Double? = nil,
        rating: Double? = nil,
        stock: Int? = nil,
        tags: [String]? = nil,
        brand: String? = nil,
        sku: String? = nil,
        weight: Double? = nil,
        dimensions: Dimensions? = nil,
        warrantyInformation: String? = nil,
        shippingInformation: String? = nil,
        availabilityStatus: String? = nil,
        reviews: [Review]? = nil,
        returnPolicy: String? = nil,
        minimumOrderQuantity: Int? = nil,
        meta: Meta? = nil,
        thumbnail: String? = nil,
        images: [String]? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.tags = tags
        self.brand = brand
        self.sku = sku
        self.weight = weight
        self.dimensions = dimensions
        self.warrantyInformation = warrantyInformation
        self.shippingInformation = shippingInformation
        self.availabilityStatus = availabilityStatus
        self.reviews = reviews
        self.returnPolicy = returnPolicy
        self.minimumOrderQuantity = minimumOrderQuantity
        self.meta = meta
        self.thumbnail = thumbnail
        self.images = images
    }

    private enum CodingKeys: String, CodingKey {
        case id, title, description, category, price, discountPercentage, rating, stock, tags,
             brand, sku, weight, dimensions, warrantyInformation, shippingInformation,
             availabilityStatus, reviews, returnPolicy, minimumOrderQuantity, meta, thumbnail, images
    }
}

// MARK: - Dimensions
public struct Dimensions: StandardModel {
    public var id: UUID = .init()
    public let width: Double?
    public let height: Double?
    public let depth: Double?

    private enum CodingKeys: String, CodingKey { case width, height, depth }

    public init(id: UUID = .init(), width: Double?, height: Double?, depth: Double?) {
        self.id = id
        self.width = width
        self.height = height
        self.depth = depth
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.id = .init() // JSON’dan gelmiyor
        self.width  = try c.decodeIfPresent(Double.self, forKey: .width)
        self.height = try c.decodeIfPresent(Double.self, forKey: .height)
        self.depth  = try c.decodeIfPresent(Double.self, forKey: .depth)
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(width,  forKey: .width)
        try c.encodeIfPresent(height, forKey: .height)
        try c.encodeIfPresent(depth,  forKey: .depth)
        // id'yi encode etmiyoruz
    }
}

// MARK: - Review
public struct Review: StandardModel {
    public var id: UUID = .init()
    public let rating: Int?
    public let comment: String?
    public let date: String?
    public let reviewerName: String?
    public let reviewerEmail: String?

    private enum CodingKeys: String, CodingKey {
        case rating, comment, date, reviewerName, reviewerEmail
    }

    public init(
        id: UUID = .init(),
        rating: Int?, comment: String?, date: String?,
        reviewerName: String?, reviewerEmail: String?
    ) {
        self.id = id
        self.rating = rating
        self.comment = comment
        self.date = date
        self.reviewerName = reviewerName
        self.reviewerEmail = reviewerEmail
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.id = .init()
        self.rating = try c.decodeIfPresent(Int.self,    forKey: .rating)
        self.comment = try c.decodeIfPresent(String.self, forKey: .comment)
        self.date = try c.decodeIfPresent(String.self,    forKey: .date)
        self.reviewerName  = try c.decodeIfPresent(String.self, forKey: .reviewerName)
        self.reviewerEmail = try c.decodeIfPresent(String.self, forKey: .reviewerEmail)
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(rating, forKey: .rating)
        try c.encodeIfPresent(comment, forKey: .comment)
        try c.encodeIfPresent(date, forKey: .date)
        try c.encodeIfPresent(reviewerName, forKey: .reviewerName)
        try c.encodeIfPresent(reviewerEmail, forKey: .reviewerEmail)
    }
}

// MARK: - Meta
public struct Meta: StandardModel {
    public var id: UUID = .init()
    public let createdAt: String?
    public let updatedAt: String?
    public let barcode: String?
    public let qrCode: String?

    private enum CodingKeys: String, CodingKey { case createdAt, updatedAt, barcode, qrCode }

    public init(id: UUID = .init(), createdAt: String?, updatedAt: String?, barcode: String?, qrCode: String?) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.barcode = barcode
        self.qrCode = qrCode
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.id = .init()
        self.createdAt = try c.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try c.decodeIfPresent(String.self, forKey: .updatedAt)
        self.barcode   = try c.decodeIfPresent(String.self, forKey: .barcode)
        self.qrCode    = try c.decodeIfPresent(String.self, forKey: .qrCode)
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encodeIfPresent(createdAt, forKey: .createdAt)
        try c.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try c.encodeIfPresent(barcode,   forKey: .barcode)
        try c.encodeIfPresent(qrCode,    forKey: .qrCode)
    }
}
