//
//  DesignableView.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 15.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
