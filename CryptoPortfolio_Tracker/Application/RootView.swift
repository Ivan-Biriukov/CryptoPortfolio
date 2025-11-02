import SwiftUI

struct RootView: View {
    @AppStorage("is_ob_finished") private var isOnboardingShown = false
//    @State private var onboardingRouter: OnboardingRouter
    @State private var onboardingViewModel: OnboardingViewModel
    
    init() {
        self._onboardingViewModel = State(wrappedValue: OnboardingViewModel())
    }

    var body: some View {
        Group {
            if !isOnboardingShown {
                OnboardingFactory().build(from: (), viewModel: onboardingViewModel)
            } else {
                Text("Main App Starts Here")
            }
        }
    }
}

//MARK: - Methods
private extension RootView {
    func configureEntities() {
        
    }
}

#Preview {
    RootView()
}
