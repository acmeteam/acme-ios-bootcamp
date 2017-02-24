//
//  PhotoCollectionHeaderView.swift
//  PhotoGallery
//
//  Created by Petar Cvijic on 1/27/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class PhotoCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!

    var title: String! {
        didSet {
            titleLabel?.text = title
         }
    }
}
