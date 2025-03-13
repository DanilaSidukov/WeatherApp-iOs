import UIKit
import SwiftUI
import Foundation

final class LocationsViewController: UIViewController {
    
    private let locationsDataManager = WeatherCoreDataService.shared
    private let locationRepository = LocationRepository.shared
    
    private let buttonAdd = ButtonAdd()
        
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
        setupView()
    }
}

private extension LocationsViewController {
    
    func setupView() {
        
        view.backgroundColor = .baseBackground
        
        addSubViews()
        setupConstraints()
    }
}

private extension LocationsViewController {
    
    func addSubViews() {
        self.collectionView.allowsMultipleSelection = false
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        locationsDataManager.getAllLocations()
        
        buttonAdd.onClick = {
            let textFieldWindow = TextFieldWindow.initDialog() { text in
                self.getLocation(city: text)
            }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            textFieldWindow.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
           
            
            self.present(textFieldWindow, animated: true, completion: nil)
        
        }
        
        view.addSubview(collectionView)
        view.addSubview(buttonAdd)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func dismissAlertController(city: String) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getLocation(city: String) {
        if (!city.isEmpty) {
            Task {
                let response = try await locationRepository.getLocationData(city: city)
                DispatchQueue.main.async {
                    self.locationsDataManager.addLocation(locationData: response)
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

private extension LocationsViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            buttonAdd.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonAdd.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        ])
    }
}

extension LocationsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationsDataManager.locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as? LocationCollectionViewCell else { fatalError("Error LocationCollectionViewCell") }
        
        let item = locationsDataManager.locations[indexPath.row]
        cell.configure(with: item.convertToLocationItemView())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 164, height: 154)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let uiEdgeInsets = centerItemsInCollectionView(cellWidth: 164, numberOfItems: 2, spaceBetweenCell: 16, collectionView: collectionView)
        return uiEdgeInsets
    }
}
