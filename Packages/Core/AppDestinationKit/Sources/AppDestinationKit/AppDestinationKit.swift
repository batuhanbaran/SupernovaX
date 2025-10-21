import NavigatorUI
import SwiftUI

// Shared navigation destinations that all modules can use
nonisolated public enum AppDestinations: NavigationProvidedDestination {
    // Product List destinations
    case productList

    // Product Detail destinations
    case productDetail(productId: String)

    case authentication
}

public struct AppNavigationCheckpoints: NavigationCheckpoints {
    // ✅ Void checkpoints - sadece konuma dönüş
    public static var home: NavigationCheckpoint<Void> { checkpoint() }
    public static var productList: NavigationCheckpoint<Void> { checkpoint() }
    public static var productDetail: NavigationCheckpoint<Void> { checkpoint() }
    public static var cart: NavigationCheckpoint<Void> { checkpoint() }

    // ✅ Value checkpoints - değer döndürme ile
//    public static var productSelection: NavigationCheckpoint<String> { checkpoint() }
//    public static var filterApplied: NavigationCheckpoint<FilterOptions> { checkpoint() }
//    public static var sortApplied: NavigationCheckpoint<SortOption> { checkpoint() }
//    public static var checkoutComplete: NavigationCheckpoint<OrderResult> { checkpoint() }
}

//public enum FilterOptions: Hashable {
//    case all
//    case priceRange(min: Double, max: Double)
//    case category(String)
//    case inStock
//}
//
//public enum SortOption: Hashable {
//    case nameAsc
//    case nameDesc
//    case priceLowToHigh
//    case priceHighToLow
//    case newest
//}
//
//public struct OrderResult: Hashable {
//    public let orderId: String
//    public let success: Bool
//    public let message: String
//}
