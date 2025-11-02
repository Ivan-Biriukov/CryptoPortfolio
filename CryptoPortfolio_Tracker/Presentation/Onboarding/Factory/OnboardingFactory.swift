import Foundation

struct OnboardingFactory: Factory {
    typealias Context = Void
    typealias View = OnboardingView
    typealias ViewModel = OnboardingViewModel

    func build(from context: Context, viewModel: ViewModel) -> View {
        OnboardingView(viewModel: viewModel)
    }
}
