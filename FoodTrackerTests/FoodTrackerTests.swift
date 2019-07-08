//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by UAG on 2019/7/5.
//  Copyright © 2019 DC. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    //MARK: meal class test
   // Confirm that the Meal initializer return a Meal object when passed valid parameters
    func testMealInitializationSucceeds()  {
        // zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //height positive rating
        let heightPositiveMeal = Meal.init(name: "hei", photo: nil, rating: 5)
        XCTAssertNotNil(heightPositiveMeal)
    }
    
    // Confirm that the Meal initializer returns nil when pass a nagative rating or an empty name
    func testMealInitializerFail(){
        //negative rating
        let negetiveRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negetiveRatingMeal)
        
        //empty name
        let emptyNameMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyNameMeal)
        
        //large rating
        let largeRatingMeal  = Meal.init(name: "LargeRating", photo: nil, rating: 9)
        XCTAssertNil(largeRatingMeal)
        
    }
}
