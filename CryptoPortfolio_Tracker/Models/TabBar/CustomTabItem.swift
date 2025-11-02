import Foundation

enum CustomTabItem: String, CaseIterable {
    case coins, myProfile, settings
    
    var rawValue: String {
        switch self {
        case .coins:
            "Coins List"
        case .myProfile:
            "My Actives"
        case .settings:
            "Settings"
        }
    }
    
    var tabSymbol: String {
        switch self {
        case .coins:
            "list.star"
        case .myProfile:
            "brain.filled.head.profile"
        case .settings:
            "gear"
        }
    }
    
    var actionSymbol: String {
        switch self {
        case .coins:
            "sparkle.magnifyingglass"
        case .myProfile:
            "wallet.bifold.fill"
        case .settings:
            "envelope.stack"
        }
    }
    
    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}
