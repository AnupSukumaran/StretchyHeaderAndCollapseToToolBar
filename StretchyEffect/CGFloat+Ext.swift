//
//  CGFloat+Ext.swift
//  StrechyHead
//
//  Created by Qaptive Technologies on 20/09/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import Foundation

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

