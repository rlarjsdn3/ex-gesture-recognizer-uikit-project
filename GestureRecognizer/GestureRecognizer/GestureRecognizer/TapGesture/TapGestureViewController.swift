//
//  TapGestureViewController.swift
//  GestureRecognizer
//
//  Created by 김건우 on 12/11/23.
//

import UIKit

class TapGestureViewController: UIViewController {
    @IBOutlet weak var stackContainer: UIStackView!
    
    var mainScroll: UIScrollView!
    var image: UIImageView!
    var zooming = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImageView(image: UIImage(named: "husky"))
        
        mainScroll = UIScrollView(frame: .zero)
        mainScroll.contentSize = CGSize(
            width: image.frame.size.width,
            height: image.frame.size.height
        )
        mainScroll.minimumZoomScale = 1.0
        mainScroll.maximumZoomScale = 4.0
        mainScroll.delegate = self
        mainScroll.addSubview(image)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(zoomPicture))
        mainScroll.addGestureRecognizer(gesture)
        
        stackContainer.addArrangedSubview(mainScroll)
    }

    @objc func zoomPicture(sender: UITapGestureRecognizer) {
        if !zooming {
            let position = sender.location(in: mainScroll)
            mainScroll.zoom(
                to: CGRect(x: position.x, y: position.y, width: 1, height: 1),
                animated: true
            )
            zooming = true
        } else {
            mainScroll.setZoomScale(1.0, animated: true)
            zooming = false
        }
    }
}

extension TapGestureViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
}
