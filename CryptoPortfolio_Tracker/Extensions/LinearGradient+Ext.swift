import SwiftUI

extension LinearGradient {
    static let onboardingGradient: LinearGradient = .linearGradient(
        Gradient(stops: [
            .init(color: Color(hex: "8AD4EC"), location: 0),
            .init(color: Color(hex: "EF96FF"), location: 0.22),
            .init(color: Color(hex: "FF56A9"), location: 0.54),
            .init(color: Color(hex: "FFAA6C"), location: 0.85)
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
}

