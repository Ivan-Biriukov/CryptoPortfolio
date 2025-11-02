import SwiftUI

@Observable
final class OnboardingViewModel {
    @ObservationIgnored
    @AppStorage("is_ob_finished") var isOnboardingShown: Bool = false
    
    var selectedPage: OnboardingTab = .first
    var shouldDisplaypurchView: Bool {
        selectedPage == .purch
    }
    
    func mainBtnTaped() {
        switch selectedPage {
        case .first:
            selectedPage = .second
        case .second:
            selectedPage = .third
        case .third:
            withAnimation {
                selectedPage = .purch
            }
        case .purch:
            //TODO: - add logic
            withAnimation {
                isOnboardingShown.toggle()
            }
        }
    }
    
    func continuewTrial() {
        //TODO: - add logic
        withAnimation {
            isOnboardingShown.toggle()
        }
    }
}
