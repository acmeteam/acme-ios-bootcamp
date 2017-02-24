import UIKit
import Photos

enum GridSettings {
    static let MinItemsPerRow = 1
    static let MaxItemsPerRow = 5
    static let SectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
}

enum GestureSettings {
    static let PinchScaleCorrection: CGFloat = 0.8
}

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    private var thumbnailSize: CGSize!
    private let photoManager = PhotoManager.shared
    private var itemsPerRow: Int = 5 {
        didSet {
            // Reload photos if collection view params are changed
            if oldValue != itemsPerRow {
                prepareThumbnailSize()
                collectionView?.reloadData()
            }
        }
    }

    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        photoManager.fetchAllPhotoAssets()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        prepareThumbnailSize()
    }
    

    // MARK:- CollectionView datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoManager.imageCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageViewCell.self), for: indexPath) as! ImageViewCell
        
        photoManager.fetchPhotoThumbnail(at: indexPath.item, targetSize: thumbnailSize) {(image, date) in
            cell.thumbnailImage = image
        }

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! PhotoCollectionHeaderView
            
            headerView.title = "All Photos"
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    // MARK:- Collection view flow layout dataflow
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = GridSettings.SectionInsets.left * (CGFloat(itemsPerRow) + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return GridSettings.SectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GridSettings.SectionInsets.left
    }
    
    // MARK:- Segue - navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinatioVC = segue.destination as? PhotoAssetViewController else {
            return
        }
        
        let indexPath = collectionView!.indexPath(for: sender as! ImageViewCell)!
        destinatioVC.assetIndex = indexPath.item
    }
    
    
    // MARK:- UIActions
    @IBAction func refreshPhotos(_ sender: UIBarButtonItem) {
        photoManager.fetchAllPhotoAssets()
        collectionView?.reloadData()
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
        var newValue = itemsPerRow - 1
        
        if newValue < GridSettings.MinItemsPerRow {
            newValue = GridSettings.MaxItemsPerRow
        }
        
        itemsPerRow = newValue
    }
    
    // MARK:- Private helpers
    private func prepareThumbnailSize() {
        // Calculate the size of the thumbnail
        let scale = UIScreen.main.scale
        let cellSize = (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
    }
}

extension Date {
    var shortDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        
        return dateFormatter.string(from: self)
    }
}



