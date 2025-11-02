import SwiftUI

fileprivate struct Constants {
    let tabHSpacing: CGFloat = 10
    let tabBarHeight: CGFloat = 55
    let tabBarHPaddings: CGFloat = 20
    
    let tabItemVSpacing: CGFloat = 5
    let tabItemTitleFontSize: CGFloat = 12
    let tabAdditionalImageSize: CGFloat = 22
    let tabAdditionalImageFrame: CGSize = .init(width: 55, height: 55)
    
    let doteBlendModeHeight: CGFloat = 50
}

struct CPTTabbarView: View {
    @State private var activeTab: CustomTabItem = .coins
    private let k = Constants()
    
    var body: some View {
        TabView(selection: $activeTab) {
            Tab(value: .coins) {
                tabContent(
                    Text("Coins")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                        .toolbarVisibility(.hidden, for: .tabBar)
                )
            }
            
            Tab.init(value: .myProfile) {
                Text("Profile")
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            
            Tab.init(value: .settings) {
                Text("Settings")
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
        .safeAreaInset(edge: .bottom) {
            if #available(iOS 26, *) {
                HStack(spacing: k.tabHSpacing) {
                    GeometryReader {
                        tabBarContent(with: $0.size)
                            .glassEffect(.regular.interactive(), in: .capsule)
                    }
                    
                    innerZStack
                        .glassEffect(.regular.interactive(), in: .capsule)
                }
                .frame(height: k.tabBarHeight)
                .padding(.horizontal, k.tabBarHPaddings)
            } else {
                HStack(spacing: k.tabHSpacing) {
                    GeometryReader {
                        tabBarContent(with: $0.size)
                    }
                    
                    innerZStack
                    
                }
                .frame(height: k.tabBarHeight)
                .padding(.horizontal, k.tabBarHPaddings)
            }
        }
    }
}

//MARK: - UI Components
private extension CPTTabbarView {
    @ViewBuilder
    func tabBarContent(with size: CGSize) -> some View {
        CustomTabBar(
            activeTab: $activeTab,
            size: size,
            activeTabTint: .AppColors.TabBar.seletedItem,
            barTint: .AppColors.TabBar.unselectedItem
        ) { tab in
            VStack(spacing: k.tabItemVSpacing) {
                Image(systemName: tab.tabSymbol)
                    .font(.title3)
                
                Text(tab.rawValue)
                    .font(.system(size: k.tabItemTitleFontSize))
                    .fontWeight(.medium)
            }
            .symbolVariant(.fill)
            .frame(maxWidth: .infinity)
        }
    }
    
    var innerZStack: some View {
        ZStack {
            ForEach(CustomTabItem.allCases, id:\.rawValue) { tab in
                Image(systemName: tab.actionSymbol)
                    .font(.system(size: k.tabAdditionalImageSize, weight: .medium))
                    .blureFade(activeTab == tab)
            }
        }
        .frame(
            width: k.tabAdditionalImageFrame.width,
            height: k.tabAdditionalImageFrame.height
        )
        .animation(.smooth(duration: 0.55), value: activeTab)
    }
    
    @ViewBuilder
    var iosVersionAdaptiveContent: some View {
        if #available(iOS 26, *) {
            GlassEffectContainer {
                
            }
        }
    }
}

//MARK: - Tab Builder Methods
private extension CPTTabbarView {
    @ViewBuilder
    func tabContent<Content: View>(_ content: Content) -> some View {
        if #available(iOS 26, *) {
            content
                .safeAreaBar(edge: .bottom) {
                    Text(".")
                        .blendMode(.destinationOver)
                        .frame(height: k.doteBlendModeHeight)
                }
                .toolbarVisibility(.hidden, for: .tabBar)
        } else {
            content
                .toolbarVisibility(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    CPTTabbarView()
}
