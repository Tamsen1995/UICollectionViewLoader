
import UIKit

class ImageDetailController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView : UIImageView? // The view which will contain the UIImage
    var imageData : Data? // The data of the image
    var viewTitle : String? // The title of the image which will be set to the view's title
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = imageData, let newTitle = viewTitle {
            self.title = newTitle
            print("IMAGEDETAILCONTROLLER: VIEWDIDLOAD")

            imageView = UIImageView(image: UIImage(data: data))
            if let imageView = imageView {
                self.scrollView.addSubview(imageView)
                self.scrollView.contentSize = imageView.frame.size
            }
        }
        
    }
    private func updateMinZoomScaleForSize(size: CGSize) {
        print("in updateMinZoomScale")
        // checking if the
        if let imageView = imageView {
            // calculating the scale factor for both height and width
            // then determening the lesser one of the two
            let widthScale = size.width / imageView.bounds.width
            let heightScale = size.height / imageView.bounds.height
            let minScale = min(widthScale, heightScale)
            
            // A zoom scale scale is the size to which a picture is zoomed
            // when applied to a view it will determine how far out one may zoom the picture
            
            print("changing minimumZoomScale")
            scrollView.minimumZoomScale = minScale // limiting the minimum scale for zooming the picture
            scrollView.zoomScale = minScale // setting the default zoom scale of the picture

        }
    }
    
    // When the bounds change we have to re-adjust the view's subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
        
        // updating the minimum zoom scale with my self made function
        updateMinZoomScaleForSize(size: scrollView.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}






