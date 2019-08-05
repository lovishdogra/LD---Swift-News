//
//  ArticleListCollectionViewCell.swift
//  LD - Swift News
//
//  Created by Lovish Dogra on 2019-08-04.
//  Copyright © 2019 Lovish Dogra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ArticleListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    let imageCache = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    
    // MARK: IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var leadingConstraint_LabelTitle: NSLayoutConstraint!
    
    override func prepareForReuse() {
        labelTitle.text = ""
        imageView.image = nil
    }
    
    func setupCellLayout(title: String, imageURL: String) {
        self.labelTitle.text = title
        
        DispatchQueue.main.async {
            Alamofire.request(URL(string: imageURL)!).responseImage { response in
                if response.result.value != nil {
                    self.imageView.isHidden = false
                    self.leadingConstraint_LabelTitle.constant = 140
                    let image = UIImage(data: response.data!, scale: 1.0)!
                    self.imageCache.add(image, withIdentifier: imageURL)
                    // self.imageView.image = image
                    if let imageData = self.imageCache.image(withIdentifier: imageURL)
                    {
                        self.imageView.image = imageData
                    }
                } else {
                    self.imageView.isHidden = true
                    self.leadingConstraint_LabelTitle.constant = 20
                }
            }
        }
        self.layoutIfNeeded()
    }
}
