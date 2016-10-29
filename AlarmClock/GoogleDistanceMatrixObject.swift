//
//  GoogleDistanceMatrixObject.swift
//  AlarmClock
//
//  Created by ReneUser on 29.10.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import Foundation
import SwiftyJSON

class GoogleDistanceMatrixObject {
    var distanceText : String!
    var distanceValue: Int!
    var durationText : String!
    var durationValue: Int!
    var statusSearch : String!
    var statusRequest: String!      //it´s a difference if there is simple no search result or if there is something wrong with the Request

    
    required init(json: JSON) {
        //Example Url https://maps.googleapis.com/maps/api/distancematrix/json?origins=Ludwig+Erhard+Allee+32+76131+Karlsruhe&destinations=Belgien
        let response = json["rows"][0]["elements"][0]
        durationText = response["duration"]["text"].stringValue
        durationValue = response["duration"]["value"].intValue
        distanceText = response["distance"]["text"].stringValue
        distanceValue = response["distance"]["value"].intValue
        statusSearch = response["status"].stringValue
        statusRequest = json["status"].stringValue
    }
}
