//
//  SecondViewController.swift
//  StretchyEffect
//
//  Created by Qaptive Technologies on 19/09/19.
//  Copyright © 2019 Eduardo Carrillo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var headerViewMaxHeight: CGFloat!
    let headerViewMinHeight: CGFloat = 44 + UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("headerViewMinHeight = \(headerViewMinHeight)")
        headerViewMaxHeight = headerViewHeight.constant
    }
    
}

extension SecondViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //first take the scrollView's changing y axis when scrolled
        let y = scrollView.contentOffset.y
        let offset = headerViewMaxHeight - (y + headerViewMaxHeight) // this is done get the exact top scrolView inset value to get the right offset
        
        if offset < 0 {
            // here header shrinks and the offset value becomes negative, when scroll bar goes down to see the BOTTOM
            print("negative")
            //headerViewMinHeight is 88
            if headerViewHeight.constant >= headerViewMinHeight {
                
                let height = headerViewHeight.constant + offset
                let newVal = max(height, headerViewMinHeight) // takes the maximum value above 88
                print("Height = \(height)")
                //scrollView.contentInset.top = height
                //Adds the constraints and gave the animation
                headerViewHeight.constant = newVal
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
                
//                UIView.animate(withDuration: 0.5) {
//                    self.view.layoutIfNeeded()
//                }
      
            }
            

        } else {
            // here header expands and the offset value becomes positive, when scroll bar goes Up to see the TOP
            print("positive")
            //headerViewMaxHeight is 295
            if headerViewHeight.constant <= headerViewMaxHeight {
                let height = headerViewHeight.constant + offset
                let newVal = min(headerViewMaxHeight, height) // takes the min value below 295
                
                //Adds the constraints and gave the animation
                headerViewHeight.constant = newVal
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
//                UIView.animate(withDuration: 0.5) {
//                    self.view.layoutIfNeeded()
//                }
            }
        }
    }
}
