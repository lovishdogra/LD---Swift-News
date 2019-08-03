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

    // MARK: IBOutlets
    @IBOutlet weak var collectionView_ArticleList: UICollectionView!
    
    // MARK: View load method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView_ArticleList.delegate = self
        self.collectionView_ArticleList.dataSource = self
        
    }

}

// MARK: CollectionView Extension
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView_ArticleList.dequeueReusableCell(withReuseIdentifier: "articleList", for: indexPath)
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    
}
