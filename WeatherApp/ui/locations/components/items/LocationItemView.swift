import UIKit

struct LocationItemView: Hashable {
    let location: String
    var isSelected: Bool
    let temperature: String
    let temperatureRange: String
    let weatherIcon: UIImage
}
