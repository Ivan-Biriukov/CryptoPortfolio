import SwiftUI

struct OnboardingView: View {
    @State private var viewModel: OnboardingViewModel
    @Namespace var animation
    
    init(viewModel: OnboardingViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if !viewModel.shouldDisplaypurchView {
                OnboardingContentView(page: viewModel.selectedPage, namespace: animation) {
                    viewModel.mainBtnTaped()
                }
                .transition(.slide)
            } else {
                OnboardingPurchasView(contentData: viewModel.selectedPage) {
                    viewModel.mainBtnTaped()
                } onTrial: {
                    viewModel.continuewTrial()
                }
                    .transition(.slide)
            }
        }
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
