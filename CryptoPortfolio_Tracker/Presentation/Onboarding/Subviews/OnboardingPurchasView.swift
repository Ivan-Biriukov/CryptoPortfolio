import SwiftUI

fileprivate struct Constants {
    let contentImageSize: CGSize = .init(width: 290, height: 290)
    let botoomTitleFontSize: CGFloat = 40
    let btnStackVSpacing: CGFloat = 18
}

struct OnboardingPurchasView: View {
    private let k = Constants()
    var contentData: OnboardingTab
    
    let onPurchase: () -> Void
    let onTrial: () -> Void
    
    var body: some View {
        content
    }
}

//MARK: - UI Components
private extension OnboardingPurchasView {
    var content: some View {
        VStack(alignment: .center) {
            Text("Step up a level — predict your growth with Premium")
                .font(.title)
            
            Image(contentData.imageName)
                .resizable()
                .frame(width: k.contentImageSize.width, height: k.contentImageSize.height)
                .aspectRatio(contentMode: .fit)
            
            Text(contentData.whiteTitle)
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .font(.system(size: k.botoomTitleFontSize))
            
            Spacer()
            
            btnStack
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setupOnboardingViewStyle()
    }
    
    var btnStack: some View {
        VStack(alignment: .center, spacing: k.btnStackVSpacing) {
            MainBtnView(style: .coloredBG(),
                        title: contentData.secondBtnTitle ?? "") {
                onPurchase()
            }
            
            MainBtnView(style: .gradientedBG(), title: contentData.mainBtnTitle) {
                onTrial()
            }
        }
    }
}

#Preview {
    OnboardingPurchasView(contentData: .purch, onPurchase: {}, onTrial: {})
}
