import UIKit
import SwiftUI
import Foundation

class LocationsViewController: UIViewController {
    
    let items: [LocationItemView] = [
        LocationItemView(location: "Ухоу", isSelected: true, temperature: 12, temperatureRange: [6, 16], weatherIcon: UIImage(named: "ic_cloud_black_with_sun")!),
        LocationItemView(location: "Наньчон", isSelected: false, temperature: 7, temperatureRange: [4, 7], weatherIcon:
            UIImage(named: "ic_cloud_black_with_sun")!),
        LocationItemView(location: "Наньчон", isSelected: false, temperature: 7, temperatureRange: [4, 7], weatherIcon:
            UIImage(named: "ic_cloud_black_with_sun")!),
        LocationItemView(location: "Наньчон", isSelected: false, temperature: 7, temperatureRange: [4, 7], weatherIcon:
            UIImage(named: "ic_cloud_black_with_sun")!)
        ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .baseBackground
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .baseBackground
        self.setUpUI()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func setUpUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension LocationsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as? LocationCollectionViewCell else { fatalError("Error :)") }
        
        let item = self.items[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
}

extension LocationsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 164, height: 154)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let uiEdgeInsets = centerItemsInCollectionView(cellWidth: 164, numberOfItems: 2, spaceBetweenCell: 16, collectionView: collectionView)
        return uiEdgeInsets
    }
}
