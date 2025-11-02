import SwiftUI
import StoreKit
import AudioToolbox

enum HapticIntensity {
    case light, soft, medium, hard
}

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
    
    ///Blure fade in/out
    @ViewBuilder
    func blureFade(_ status: Bool) -> some View {
        self
            .compositingGroup()
            .blur(radius: status ? 0 : 10)
            .opacity(status ? 1 : 0)
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
    /// Haptic trigger + system sound
    /// - Parameters:
    ///   - intensity: haptic intensivity level  (light / soft / medium / hard)
    ///   - soundId: System sound ID for aditional effect (default 1519)
    func triggerHaptic(intensity: HapticIntensity = .medium, soundId: SystemSoundID = 1519) {
        #if os(iOS)
        if UIDevice.current.hasHapticEngine {
            let style: UIImpactFeedbackGenerator.FeedbackStyle
            switch intensity {
            case .light: style = .light
            case .soft: style = .soft
            case .medium: style = .medium
            case .hard: style = .heavy
            }
            
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.impactOccurred()
            
            AudioServicesPlaySystemSound(soundId)
        } else {
            // fallback: simple vibration on device without haptic
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        #endif
    }
}


//MARK: - Onboarding Flow
extension View {
    func setupOnboardingViewStyle() -> some View {
        self
            .background {
                Color.AppColors.Onboarding.bgColor
                    .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden()
    }
}
