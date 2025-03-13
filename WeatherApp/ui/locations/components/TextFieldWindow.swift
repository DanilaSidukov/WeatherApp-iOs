import SwiftUI
import Foundation

final class TextFieldWindow {
    
    static func initDialog(
        title: String = stringRes("add_location"),
        message: String? = nil,
        completionOk: ((String) -> Void)? = nil
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(title: stringRes("add"), style: .default) {_ in
                completionOk?(alert.textFields!.first?.text ?? String.empty)
            }
        )
        alert.addTextField(
            configurationHandler: {(textField: UITextField!) in
                textField.placeholder = stringRes("input_location_name")
            }
        )
        
        return alert
    }
}
