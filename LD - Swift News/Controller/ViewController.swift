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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkRequest.getSwiftNews { (response, error) in
            DispatchQueue.main.async {
                let data = response?.data?.children
                for result in data! {
                    let newsData = result.data
                    self.swiftNewsData?.append(newsData!)
                    //print(newsData?.thumbnail!)
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
        let cell = self.collectionView_ArticleList.dequeueReusableCell(withReuseIdentifier: "articleList", for: indexPath) as! ArticleListCollectionViewCell
        //cell.backgroundColor = UIColor.gray
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 5
        
        if let data = self.swiftNewsData?[indexPath.row] {
            cell.setupTitle(title: data.title!)
            cell.setupImage(imageURL: data.thumbnail!)
            //cell.setupCellLayout(title: data.title!, imageURL: data.thumbnail ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 10.0, height: 165.0)
    }
    
}
