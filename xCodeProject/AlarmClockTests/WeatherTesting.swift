//
//  WeatherTesting.swift
//  AlarmClock
//
//  Created by René Penkert on 20.04.17.
//  Copyright © 2017 ReneUser. All rights reserved.
//

import XCTest
@testable import AlarmClock

class WeatherTesting: XCTestCase {
    let longKA = 8.39
    let latKA = 49.0
    var temp_expectation : XCTestExpectation? = nil
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testWeatherApiWithKarlsruheCoords()
    {
        let requestExpectation = self.expectation(description: "Request")
        temp_expectation = requestExpectation
        let weatherAPIHandler = WeatherAPIHandler.sharedInstance
        weatherAPIHandler.getWeather(long: longKA, lat: latKA, closure: testWeather)
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTAssert(false)
            }
        }
    }
    
    private func testWeather(weather : Weather)
    {
        XCTAssertEqual(weather.long, longKA,"The Request doesn´t contain the request long")
        XCTAssertEqual(weather.lat, latKA,"The Request doesn´t contain the request lat")
        XCTAssertNotEqual(weather.humidity, 0.0,"Keine Humidity zurückgegeben")
        XCTAssertNotEqual(weather.sunrise, 0,"Keine Sunrise zurückgegeben")
        XCTAssertNotEqual(weather.temp, 0.0,"Keine Temperatur zurückgegeben")
        temp_expectation?.fulfill()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
