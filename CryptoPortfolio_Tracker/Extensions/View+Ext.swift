import SwiftUI
import StoreKit

//MARK: - ViewBuilders + Modifiers
extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    ///Use to specified selected corners to be rounded
    func cornerRad(_ cornerRadius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(CustomRectangle(cornerRadius: cornerRadius, corners: corners))
    }
}

//MARK: - Global properties
extension View {
    var isiPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    ///Return bool in condition of screen.height < 700
    var isSmallDevice: Bool {
        UIScreen.main.bounds.height < 700
    }
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

//MARK: - Methods
extension View {
    func requestReview() {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive })
                as? UIWindowScene {
                AppStore.requestReview(in: scene)
            }
        }
    }
    
    /// (_ link: String)
    func openLinkInSafaryTab(_ linkString: String) {
        if let termsURL = URL(string: "\(linkString)") {
            UIApplication.shared.open(termsURL)
        }
    }
}
