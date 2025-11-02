import SwiftUI

struct CustomTabBar<TabBarItemView: View>: UIViewRepresentable {
    @Binding var activeTab: CustomTabItem
    var size: CGSize
    var activeTabTint: Color = .blue
    var barTint: Color = .gray.opacity(0.15)
    @ViewBuilder var tabItemView: (CustomTabItem) -> TabBarItemView
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UISegmentedControl {
        let items = CustomTabItem.allCases.map(\.rawValue)
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = activeTab.index
        
        //Converting tab item view into the image
        for (index, tab) in CustomTabItem.allCases.enumerated() {
            let render = ImageRenderer(content: tabItemView(tab))
            render.scale = 2
            let image = render.uiImage
            
            control.setImage(image, forSegmentAt: index)
        }
        
        DispatchQueue.main.async {
            for subview in control.subviews {
                if subview is UIImageView && subview != control.subviews.last {
                    //this will be bg image view
                    subview.alpha = 0
                }
            }
        }
        
        control.selectedSegmentTintColor = UIColor(barTint)
        control.setTitleTextAttributes(
            [.foregroundColor : UIColor(activeTabTint)],
            for: .selected
        )
        
        control.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.tabSelected(_:)),
            for: .valueChanged
        )
        
        return control
    }
    
    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UISegmentedControl, context: Context) -> CGSize? {
        return size
    }
    
    class Coordinator: NSObject {
        var parent: CustomTabBar
        
        init(parent: CustomTabBar) {
            self.parent = parent
        }
        
        @objc func tabSelected(_ control: UISegmentedControl) {
            parent.activeTab = CustomTabItem.allCases[control.selectedSegmentIndex]
        }
    }
}
