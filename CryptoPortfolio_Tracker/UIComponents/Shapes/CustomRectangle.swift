import SwiftUI

struct CustomRectangle: Shape {
    let cornerRadius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        ).cgPath)
    }
}
