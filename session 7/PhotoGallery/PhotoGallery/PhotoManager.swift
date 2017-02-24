import Foundation
import Photos

class PhotoManager {
    static let shared = PhotoManager()
    
    var fetchResult: PHFetchResult<PHAsset>?
    
    fileprivate let imageManager = PHCachingImageManager()
    
     func fetchAllPhotoAssets()
     {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
    }
    
    var imageCount: Int {
        return fetchResult?.count ?? 0
    }
    
    func fetchPhotoThumbnail(at index: Int, targetSize: CGSize, resultHandler: @escaping (UIImage?, Date?) -> Void ){
        
        guard let fetchResult = fetchResult else {
            resultHandler(nil, nil)
            return
        }
        
        let asset = fetchResult.object(at: index)
        let assetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            if assetIdentifier == asset.localIdentifier {
                resultHandler(image, asset.creationDate)
            } else {
                resultHandler(nil, nil)
            }
        })
    }
    
    func fetchFullSizePhoto(at index: Int, targetSize: CGSize, resultHandler: @escaping (UIImage?) -> Void ) {
        guard let asset = fetchResult?.object(at: index) else {
            resultHandler(nil)
            return
        }
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat

        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { image, _ in
                resultHandler(image)
        })
    }  
}
