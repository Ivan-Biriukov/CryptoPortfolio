import SwiftUI
import AudioToolbox

enum MainBtnViewStyle {
    case gradientedBG(
        graiend: LinearGradient = .onboardingGradient,
        cornerRadius: CGFloat = 80,
        texColor: Color = .white
    )
    case coloredBG(
        bgColor: Color = .AppColors.Onboarding.btnColoredBG,
        cornerRadius: CGFloat = 80,
        texColor: Color = .white
    )
    case onlyText(textColot: Color = .white)
}

struct MainBtnView: View {
    let style: MainBtnViewStyle
    let title: String
    var hapticIntensivity: (intensity: HapticIntensity, soundID: SystemSoundID) = (.medium, 1519)
    let action: () -> Void
    
    var body: some View {
        Button {
            self.triggerHaptic(intensity: hapticIntensivity.intensity, soundId: hapticIntensivity.soundID)
            action()
        } label: {
            content
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}

private extension MainBtnView {
    @ViewBuilder
    var content: some View {
        switch style {
        case .gradientedBG(graiend: let gradient, cornerRadius: let radius, texColor: let textColor):
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .foregroundStyle(textColor)
                .background(
                    gradient,
                    in: RoundedRectangle(cornerRadius: radius)
                )
        case .coloredBG(bgColor: let bgColor, cornerRadius: let radius, texColor: let textColor):
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .foregroundStyle(textColor)
                .background(
                    bgColor,
                    in: RoundedRectangle(cornerRadius: radius)
                )
        case .onlyText(textColot: let textColor):
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .foregroundStyle(textColor)
        }
    }
}

#Preview {
    MainBtnView(style: .gradientedBG(graiend: LinearGradient.onboardingGradient), title: "Test", action: {})
}
