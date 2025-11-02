import SwiftUI

public protocol Factory {
    associatedtype Context
    associatedtype View
    associatedtype ViewModel
    
    func build(from context: Context, viewModel: ViewModel) -> View
}
