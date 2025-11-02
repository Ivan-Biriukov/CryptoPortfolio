import SwiftUI

fileprivate struct Constants {
    let contentImageSize: CGSize = .init(width: 290, height: 290)
    let pageCircleIndicatorSize: CGSize = .init(width: 8, height: 8)
    let mainBtnPadings: CGFloat = 32
}

struct OnboardingContentView: View {
    private let k = Constants()
    var page: OnboardingTab
    let namespace: Namespace.ID
    let mainBtnAction: () -> Void
    
    var body: some View {
        content
            .animation(.linear(duration: 0.3), value: page)
    }
}

private extension OnboardingContentView {
    var content: some View {
        VStack {
            Image(page.imageName)
                .resizable()
                .frame(width: k.contentImageSize.width, height: k.contentImageSize.height)
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            titleStack
            
            Spacer()
            
            pageIndicator
            
            MainBtnView(style: .gradientedBG(), title: page.mainBtnTitle) {
                mainBtnAction()
            }
            .matchedGeometryEffect(id: "purchas", in: namespace)
            .padding(k.mainBtnPadings)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setupOnboardingViewStyle()
    }
    
    var titleStack: some View {
        Group {
            if page != .third && page != .purch {
                VStack(alignment: .center, spacing: 18) {
                    Text(page.whiteTitle)
                        .fontWeight(.regular)
                        .foregroundStyle(.white)
                    
                    Text(page.coloredTitle ?? "")
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient.onboardingGradient)
                }
            } else {
                VStack(alignment: .center, spacing: 18) {
                    Text(page.coloredTitle ?? "")
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient.onboardingGradient)
                    
                    Text(page.whiteTitle)
                        .fontWeight(.regular)
                        .foregroundStyle(.white)
                }
            }
        }
        .font(.system(size: 40))
    }
    
    var pageIndicator: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(
                        index == page.pageIndex ? Color.AppColors.Onboarding.activePageIndicator : Color.AppColors.Onboarding.unActivePageIndicator
                    )
                    .frame(width: k.pageCircleIndicatorSize.width, height: k.pageCircleIndicatorSize.height)
            }
        }
    }
}

#Preview {
    OnboardingContentView(page: .first, namespace: Namespace().wrappedValue, mainBtnAction: {})
}
