import Foundation

enum OnboardingTab: CaseIterable, Identifiable {
    var id: Self { self }
    
    case first, second, third, purch
    
    var imageName: String {
        switch self {
        case .first:
            "OBContentImg1"
        case .second:
            "OBContentImg2"
        case .third:
            "OBContentImg3"
        case .purch:
            "OBContentImg4"
        }
    }
    
    var whiteTitle: String {
        switch self {
        case .first:
            "Property"
        case .second:
            "Safe"
        case .third:
            "Transaction"
        case .purch:
            "Take it to the next level"
        }
    }
    
    var coloredTitle: String? {
        switch self {
        case .first:
            "Diversity"
        case .second:
            "Security"
        case .third:
            "Convenient"
        case .purch:
            nil
        }
    }
    
    var pageIndex: Int? {
        switch self {
        case .first:
            0
        case .second:
            1
        case .third:
            2
        case .purch:
            nil
        }
    }
    
    var mainBtnTitle: String {
        switch self {
        case .first, .second, .third:
            "Next"
        case .purch:
            "Get started with Pro"
        }
    }
    
    var secondBtnTitle: String? {
        switch self {
        case .purch:
            "Continue with the free version"
        default: nil
        }
    }
}
