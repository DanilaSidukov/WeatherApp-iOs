import UIKit

struct LocationItemView: Hashable {
    let location: String
    let isSelected: Bool
    let temperature: Int
    let temperatureRange: [Int?]
    let weatherIcon: UIImage
}
