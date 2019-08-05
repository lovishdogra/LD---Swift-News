//
//  ArticleViewController.swift
//  LD - Swift News
//
//  Created by Lovish Dogra on 2019-08-04.
//  Copyright © 2019 Lovish Dogra. All rights reserved.
//

import UIKit
import Alamofire

class ArticleDetailViewController: UIViewController {
    
    // MARK: Properties
    var articleTitle: String!
    var articleDetail: String!
    var articleImage: String?
    //var detail: SwiftNewsPropModel?
    
    @IBOutlet weak var imageviewThumbnail: UIImageView!
    @IBOutlet weak var labelArticleDetail: UILabel!
    @IBOutlet weak var topConstraint_articleDetail: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.articleTitle
        
//        print("🚀")
//        print("articleDetail: \(self.detail?.selftext)")
//        print("articleImage: \(self.detail?.thumbnail)")
//        print("📱")
        
    }
    
    override func viewDidLayoutSubviews() {
        setupArticleLayout(detail: self.articleDetail, imageURL: self.articleImage ?? "")
    }
    
    func setupArticleLayout(detail: String, imageURL: String) {
        self.labelArticleDetail.text = self.articleDetail
        print(self.articleDetail as Any)
        
        DispatchQueue.main.async {
            Alamofire.request(URL(string: imageURL)!).responseImage { response in
                if response.result.value != nil {
                    self.imageviewThumbnail.isHidden = false
                    self.topConstraint_articleDetail.constant = 218
                    let image = UIImage(data: response.data!, scale: 1.0)!
                    self.imageviewThumbnail.image = image

                } else {
                    self.imageviewThumbnail.isHidden = true
                    self.topConstraint_articleDetail.constant = 8
                }
            }
        }
    }
    
}
