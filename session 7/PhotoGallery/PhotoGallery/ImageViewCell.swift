import UIKit

class ImageViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!

    var thumbnailImage: UIImage! {
        didSet {
            imageView?.image = thumbnailImage
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
