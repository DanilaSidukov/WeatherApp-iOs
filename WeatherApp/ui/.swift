import Foundation
import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    
    var viewControllerBuilder: () -> UIViewController
    
    init(viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
