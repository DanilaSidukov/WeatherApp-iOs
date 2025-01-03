import UIKit
import SwiftUI

class LocationCardViewCell: UIView {
    
    static let identifier: String = "LocationCardViewCell"
    
    var radius: CGFloat = 16

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    func configure(with location: LocationItemView) {
        let startRange = location.temperatureRange.first ?? nil
        let endRange = location.temperatureRange.last ?? nil
        locationLabel.text = location.location
        temperatureLabel.text = "\(location.temperature)"
        temperatureRangeLabel.text = if (startRange == nil || endRange == nil) {
            String.empty
        } else {
            "\(startRange!) - \(endRange!)"
        }
        weatherIcon.image = location.weatherIcon
        
        if (location.isSelected) {
            checkIcon.isHidden = false
            gpsIcon.isHidden = false
            textPosition.isHidden = false
        } else {
            checkIcon.isHidden = true
            gpsIcon.isHidden = true
            textPosition.isHidden = true
        }
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(locationLabel)
        addSubview(temperatureLabel)
        addSubview(temperatureRangeLabel)
        addSubview(weatherIcon)
        addSubview(checkIcon)
        addSubview(selectedStackView)
    }
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.1)
        layer.shadowOffset = CGSize(width: 0, height: 3);
        layer.shadowOpacity = 0.3
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = radius
        layer.shadowPath = shadowPath.cgPath
    }
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_check")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private let gpsIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_gps")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private let textPosition: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .secondaryText
        label.numberOfLines = 1
        label.text = stringRes("you_selected")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let selectedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Staatliches-Regular", size: 28)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureRangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Staatliches-Regular", size: 13)
        label.textColor = .secondaryText
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setupConstraints() {
        selectedStackView.addArrangedSubview(gpsIcon)
        selectedStackView.addArrangedSubview(textPosition)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            locationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            locationLabel.widthAnchor.constraint(equalToConstant: 80),
            
            checkIcon.topAnchor.constraint(equalTo: locationLabel.topAnchor),
            checkIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            checkIcon.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            
            selectedStackView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            selectedStackView.leftAnchor.constraint(equalTo: locationLabel.leftAnchor),
            
            temperatureRangeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            temperatureRangeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            temperatureLabel.bottomAnchor.constraint(equalTo: temperatureRangeLabel.topAnchor, constant: -4),
            temperatureLabel.leftAnchor.constraint(equalTo: temperatureRangeLabel.leftAnchor),
            
            weatherIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            weatherIcon.bottomAnchor.constraint(equalTo: temperatureRangeLabel.bottomAnchor),
            weatherIcon.topAnchor.constraint(equalTo: temperatureLabel.topAnchor),
        ])
    }
    
    internal func clearViewForReuse() {
        locationLabel.text = nil
        temperatureLabel.text = nil
        temperatureRangeLabel.text = nil
        weatherIcon.image = nil
    }
    
}

// Обёртка для UIView для использования в SwiftUI
struct LocationCardViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> LocationCardViewCell {
        let view = LocationCardViewCell()
        let sampleItem = LocationItemView(location: "Наньчон", isSelected: true, temperature: 7, temperatureRange: [4, 7],
            weatherIcon: UIImage(named: "ic_cloud_black_rain")!)
        view.configure(with: sampleItem)
        return view
    }
    
    func updateUIView(_ uiView: LocationCardViewCell, context: Context) {
        // Обновления для UIView, если нужно
    }
}

#Preview {
    return ZStack {
        Color.baseBackground // Фон экрана
        LocationCardViewPreview()
            .frame(width: 164, height: 154)
    }
}
