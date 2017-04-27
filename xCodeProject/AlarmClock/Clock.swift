//
//  Clock.swift
//  AlarmClock
//
//  Created by Benedikt Bosshammer on 20.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import UIKit

class Clock: UILabel {
    
    var timer = Timer()
    
    override func awakeFromNib() {
        setClock()
    }
    
    func setClock () {
        updateClock()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateClock()
            
        }
    }
    
    func updateClock() {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let string = formatter.string(from: date)
        self.text = string
    }

}
