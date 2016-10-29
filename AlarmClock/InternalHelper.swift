//
//  InternalHelper.swift
//  AlarmClock
//
//  Created by ReneUser on 29.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation

class InternalHelper
{
    static let sharedInstance = InternalHelper()
    private let propertiesName = "Properties"
    func getProperties() -> NSDictionary
    {
        let pathOfProperties = Bundle.main.path(forResource: propertiesName, ofType: "plist")
        return NSDictionary(contentsOfFile: pathOfProperties!)!
    }
}
