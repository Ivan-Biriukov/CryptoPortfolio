import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension Color {
    struct AppColors{
        struct Onboarding {
            static let bgColor: Color = .init(hex: "080A0C")
            static let activePageIndicator: Color = .init(hex: "3D8DFF")
            static let unActivePageIndicator: Color = .init(hex: "384657")
            static let btnColoredBG: Color = .init(hex: "202832")
        }
        
        struct TabBar {
            static let seletedItem: Color = .init(hex: "7878FA")
            static let unselectedItem: Color = .init(hex: "F8F8F8").opacity(0.8)
        }
    }
}
