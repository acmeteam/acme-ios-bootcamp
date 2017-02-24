/*
	Copyright (C) 2016 Apple Inc. All Rights Reserved.
	See LICENSE.txt for this sample’s licensing information
	
	Abstract:
	Displays a single photo, live photo, or video asset and demonstrates simple editing.
 */


import UIKit
import PhotosUI


class PhotoAssetViewController: UIViewController {

    let photoManager = PhotoManager.shared
    var assetIndex: Int!
    
    @IBOutlet weak var imageView: UIImageView!
 

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateUI()
    }

    private var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: imageView.bounds.width * scale,
                      height: imageView.bounds.height * scale)
    }
 
    func updateUI() {
        photoManager.fetchFullSizePhoto(at: assetIndex, targetSize: targetSize) { (image) in
            self.imageView.image = image
        }
    }
  }


