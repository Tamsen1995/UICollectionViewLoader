

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    
    // Both could be nil at any point
    var imageData : Data?
    var detailTitle : String?
    
    
 
    
    var imageInfo : (String, String)? {
        // before the imageInfo is set we start animating the activity monitor
        willSet {
            self.activityMonitor.startAnimating()
        }
        // While setting it we do this
        didSet {
            if let url = imageInfo?.1 {
                // making a request url out of the url taken out of the ImageData
                let requestUrl = URL(string: url)
                let queue = DispatchQueue.global(qos: DispatchQoS.background.qosClass)
                // adding an async operation to the dispatch queue
                queue.async {
                    // trying to extract the contents of the url out of the Data method
                    if let data = try? Data(contentsOf: requestUrl!) {
                        // if done successfully the we asynchroniously declare the content as the collection image
                        // and set its background color
                        DispatchQueue.main.async {
                            self.collectionImage.image = UIImage(data: data)
                            self.collectionImage.backgroundColor = UIColor.white
                        }
                        self.imageData = data
                        self.detailTitle = self.imageInfo?.0
                        
                    } else {
                        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                        }))
                        self.parentViewController?.present(alert, animated: true, completion: nil)
                    }
                    DispatchQueue.main.async {
                        self.activityMonitor.stopAnimating()
                    }
                    
                    ImageData.loadedCount += 1
                    if ImageData.loadedCount == ImageData.images.count {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            }
        }
    }
}

// since UICollectionViewCell inherits from UIView indirectly, we extend the UIView class
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
    
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
    
}

// and return it as an implicitly casted UIViewController class

