import UIKit.UIDevice

extension UIDevice {
    var hasHapticEngine: Bool {
        if #available(iOS 13.0, *) {
            return self.value(forKey: "_feedbackSupportLevel") as? Int ?? 0 > 0
        } else {
            return false
        }
    }
}
