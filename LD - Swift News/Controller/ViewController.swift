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
    let networkRequest = NetworkRequest()
    private var swiftNewsData: [SwiftNewsPropModel]? = [] {
        didSet {
            if swiftNewsData != nil {
                collectionView_ArticleList.reloadData()
            }
        }
    }

    // MARK: IBOutlets
    @IBOutlet weak var collectionView_ArticleList: UICollectionView!
    
    // MARK: View load method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView_ArticleList.delegate = self
        self.collectionView_ArticleList.dataSource = self
        
        networkRequest.getSwiftNews { (response, error) in
            DispatchQueue.main.async {
                let data = response?.data?.children
                for result in data! {
                    let newsData = result.data
                    self.swiftNewsData?.append(newsData!)
                }
            }
        }
        
    }

}

// MARK: CollectionView Extension
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.swiftNewsData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView_ArticleList.dequeueReusableCell(withReuseIdentifier: "articleList", for: indexPath)
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 10.0, height: 165.0)
    }
    
}
