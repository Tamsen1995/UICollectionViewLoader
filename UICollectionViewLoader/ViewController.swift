//
//  ViewController.swift
//  UICollectionViewLoader
//
//  Created by Nguyen Tam Anh Bui on 10/30/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var imageCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("View loads")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This tells the collection view how many sections of it are needed
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageData.images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSquare", for: indexPath)
        print("Does it go in here")
        if let imageCell = cell as? CollectionViewCell {
            imageCell.backgroundColor = UIColor.black
            imageCell.imageInfo = ImageData.images[indexPath.row]
        }
        return cell
    }
    
    // set cellSender as! CollectionViewCell
    // cellSender is the Collection view's cell optional
    // we cast it into an optional because later we need to test if it is still nil or not
    // if it happens to be nil well then the data hasn't been loaded yet.
    // set destination as the segue.destination as? ImageDetailContoller
    // the segue.destination is the internal destination of the segue action, so in this case the scrollView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cellSender = sender as! CollectionViewCell?,
            let destination = segue.destination as? ImageDetailController {
            if let data = cellSender.imageData,
                let detailTitle = cellSender.detailTitle {
                print("preparing segue")
                destination.imageData = data
                destination.viewTitle = detailTitle
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let cellSender = sender as! CollectionViewCell? {
            print("Testing if the segue should be performed or not")
            return cellSender.imageData != nil && cellSender.detailTitle != nil
        }
        
        return false
    }
    
    
}

