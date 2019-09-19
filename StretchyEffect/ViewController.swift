//
//  ViewController.swift
//  StretchyEffect
//
//  Created by Eduardo Carrillo on 3/31/18.
//  Copyright © 2018 Eduardo Carrillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageViewTop: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var originalHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalHeight = imageViewHeight.constant
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("\(scrollView.contentOffset.y)")
        let offset = scrollView.contentOffset.y
        let defaultTop = CGFloat(0)
        var currentTop = defaultTop
        
        if offset < 0 {
        
            currentTop = offset
            imageViewHeight.constant = originalHeight - offset
        } else {
            imageViewHeight.constant = originalHeight
        }
        

        imageViewTop.constant = currentTop
    }
}
