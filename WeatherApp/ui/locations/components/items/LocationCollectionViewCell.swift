import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    static let  identifier = "LocationCollectionViewCell"

    private let cardView: LocationCardViewCell = {
        let view = LocationCardViewCell()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .baseBackground
        
        self.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configure(with location: LocationItemView) {
        cardView.configure(with: location)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.clearViewForReuse()
    }
}

func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
    let totalWidth = cellWidth * numberOfItems
    let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
    let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
    let rightInset = leftInset
    return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
}
