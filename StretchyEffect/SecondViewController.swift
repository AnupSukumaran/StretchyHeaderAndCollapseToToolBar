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
    
    var headerViewMaxHeight: CGFloat = 0
    let headerViewMinHeight: CGFloat = 44 + UIApplication.shared.statusBarFrame.height
    var lastVelocityYSign = 0
    let arcHeight: CGFloat = 100.0
    
    var path: UIBezierPath!
    var shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        headerViewMaxHeight = headerViewHeight.constant
        scrollView.contentInset = UIEdgeInsets(top: headerViewMaxHeight, left: 0, bottom: 0, right: 0)
        createRectangle(arcHeight: arcHeight)
    }
    
    func createRectangle(arcHeight: CGFloat) {
        
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: headerView.frame.size.height/2))
    
        let geo = archHeightRadiusCreator(recWidth: headerView.frame.size.width, arcHeight: arcHeight)
        let xAxis = headerView.frame.size.width/2
       
        let yAxis = headerView.frame.size.height - geo.radius

        path.addArc(withCenter: CGPoint(x: xAxis, y: yAxis), radius:  geo.radius, startAngle: geo.startAngle.degreesToRadians, endAngle: geo.endAngle.degreesToRadians, clockwise: false)

        path.addLine(to: CGPoint(x: headerView.frame.size.width, y: 0.0))
        
        path.close()
        
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shapeLayer.shadowOpacity = 1.0
        shapeLayer.shadowRadius = 5.0
        shapeLayer.shouldRasterize = true
        shapeLayer.rasterizationScale = UIScreen.main.scale
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        headerView.layer.addSublayer(shapeLayer)
    }
    
    
    //MARK:Theorems Used - Intersecting Chord theorm and Pythagorus theorem
    func archHeightRadiusCreator(recWidth: CGFloat,arcHeight: CGFloat) -> (radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        
        let lhs = pow(recWidth/2, 2)
        let d = lhs / arcHeight
        let diameter = d + arcHeight
        let radius = diameter/2
        let endAngle = acos((recWidth / 2) / radius).radiansToDegrees
        let startAngle = CGFloat.pi.radiansToDegrees - endAngle

        return (radius,startAngle,endAngle)
    }

    
}

extension SecondViewController: UIScrollViewDelegate {
    
 
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let arcThreshold = headerViewMaxHeight / arcHeight
        let minArchThresHold = headerViewMinHeight / arcThreshold

        print("arcHeight = \((headerView.frame.height/arcThreshold) / 2 )")
        
       // print("offset = \(scrollView.contentOffset.y)")
        let y = (headerViewMaxHeight - (scrollView.contentOffset.y + headerViewMaxHeight))
        
//        let height = min(max(y, headerViewMinHeight), 400)
//        print("height = \(height)")
//        headerViewHeight.constant = height
//
//
//
        let currentVelocityY =  scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()

        if currentVelocityYSign != lastVelocityYSign && currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }



       if lastVelocityYSign < 0 {
            arcShrinks(y, arcThreshold, minArchThresHold)
//           if (headerView.frame.height/arcThreshold) <= minArchThresHold {
//               createRectangle(arcHeight: 1)
//           } else {
//               createRectangle(arcHeight: (headerView.frame.height/arcThreshold) / 2)
//           }


       } else if lastVelocityYSign > 0 {
            arcExpands(y, arcThreshold, minArchThresHold)
//            if (headerView.frame.height/arcThreshold) >= minArchThresHold {
//                createRectangle(arcHeight: (headerView.frame.height/arcThreshold) / 2)
//            } else {
//               createRectangle(arcHeight: 1)
//            }

       }
        print("Offset -> y = \(y)")
//        if y > 0 {
//            // here header shrinks and the offset value becomes negative, when scroll bar goes down to see the BOTTOM
//
//
//
//            arcShrinks(y, arcThreshold, minArchThresHold)
//
//        } else {
//            // here header expands and the offset value becomes positive, when scroll bar goes Up to see the TOP
//
//            arcExpands(y, arcThreshold, minArchThresHold)
//        }
         
      
    }
    
    
    fileprivate func arcShrinks(_ y: (CGFloat), _ arcThreshold: CGFloat, _ minArchThresHold: CGFloat) {
            
         print("123Up - \(headerViewHeight.constant)")
        
        //headerViewMinHeight is 88
        
         if headerViewHeight.constant >= headerViewMinHeight {
            print("Compare - \(headerViewHeight.constant) >= \(headerViewMinHeight) -> \(headerViewHeight.constant >= headerViewMinHeight)")
            
           
//            print("Display - \(y) < \(headerViewHeight.constant) -> \(y < headerViewHeight.constant)")
          //  if y < headerViewHeight.constant {
                print("YDas - \(y)")
                let height = headerViewHeight.constant - (headerViewMaxHeight - y)
                print("KKK -> \(height) = \(headerViewHeight.constant) - \(headerViewMaxHeight - y)")
//                 print("HHHH - \(height) = \(headerViewHeight.constant) - \(y)")
                let newVal = max(height, headerViewMinHeight) // takes the maximum value above 88
                print("NewHeight = \(height)")
                 print("newVal = \(newVal)")

                headerViewHeight.constant = newVal

                if (headerView.frame.height/arcThreshold) <= minArchThresHold {
                    print("ArchHeight -> \(1)")
                    createRectangle(arcHeight: 1)
                } else {
                    print("ArchHeight -> \(headerView.frame.height/arcThreshold)")
                    createRectangle(arcHeight: (headerView.frame.height/arcThreshold))
                }
          //  }

             
         }
     }
     
     fileprivate func arcExpands(_ y: (CGFloat), _ arcThreshold: CGFloat, _ minArchThresHold: CGFloat) {
        
         print("123Down - \(headerViewHeight.constant)")
         //headerViewMaxHeight is 295
         //if headerViewHeight.constant < headerViewMaxHeight {
        if y > 0 {
            print("YDas - \(y)")
            let height = headerViewMinHeight +  y
           print("KKK -> \(height) = \(headerViewHeight.constant) + \(y)")
            let newVal = min(headerViewMaxHeight, height) // takes the min value below 295
            
            //Adds the constraints and gave the animation
            headerViewHeight.constant = newVal
            
            if (headerView.frame.height/arcThreshold) >= minArchThresHold {
                createRectangle(arcHeight: (headerView.frame.height/arcThreshold) )
            } else {
                createRectangle(arcHeight: 1)
            }
        }
            
             
       //  }
     }
}
