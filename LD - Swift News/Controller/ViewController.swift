//
//  ViewController.swift
//  LD - Swift News
//
//  Created by Lovish Dogra on 2019-08-02.
//  Copyright © 2019 Lovish Dogra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    var activityIndicator: UIActivityIndicatorView?
    let networkRequest = NetworkRequest()
    var swiftNewsData: [SwiftNewsPropModel]? = [] {
        didSet {
                collectionView_ArticleList.reloadData()
            }
        }

    // MARK: IBOutlets
    @IBOutlet weak var collectionView_ArticleList: UICollectionView!
    
    // MARK: View load method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView_ArticleList.delegate = self
        self.collectionView_ArticleList.dataSource = self
        
        showActivityIndicator()
        
        networkRequest.getSwiftNews { (response, error) in
            DispatchQueue.main.async {
                let data = response?.data?.children
                for result in data! {
                    let newsData = result.data
                    self.swiftNewsData?.append(newsData!)
                    self.activityIndicator?.stopAnimating()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityIndicator?.startAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueArticleView" {
            guard let index = sender as? Int else { return}
            guard let vc = segue.destination as? ArticleDetailViewController else { return }
            if let detail = swiftNewsData?[index] {
                vc.articleTitle = detail.title
                vc.articleDetail = detail.selftext
                vc.articleImage = detail.thumbnail
            }
        }
    }
    
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator?.center = self.view.center
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.style = .whiteLarge
        self.view.addSubview(activityIndicator!)
        
    }
    
}

// MARK: CollectionView Extension
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.swiftNewsData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView_ArticleList.dequeueReusableCell(withReuseIdentifier: "articleList", for: indexPath) as! ArticleListCollectionViewCell
        
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.gray.cgColor
        
        if let data = self.swiftNewsData?[indexPath.row] {
            cell.setupCellLayout(title: data.title!, imageURL: data.thumbnail ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueArticleView", sender: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let title = self.swiftNewsData?[indexPath.row].title {
            let approximateWidthOfTitleLabel = view.frame.width - 100 - 90 - 20 - 10
            let size = CGSize(width: approximateWidthOfTitleLabel, height: 1000)
            let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            let estimateFrame = NSString(string: title).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
            return CGSize(width: self.view.frame.width, height: estimateFrame.height + 66)
        }
        return CGSize(width: self.view.frame.width, height: 165.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
