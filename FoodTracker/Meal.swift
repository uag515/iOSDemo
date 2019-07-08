//
//  Meal.swift
//  FoodTracker
//
//  Created by UAG on 2019/7/8.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class Meal {
    //MARK: properties
    var name: String
    var photo: UIImage?
    var rating:Int
    
    //MARK: initialize
    init?(name: String, photo: UIImage?, rating: Int) {
       
        //Initialization shoud fail if there is no name or the rating is nagative
        if (name.isEmpty || rating < 0){
            return nil
        }
        guard !name.isEmpty else{
            return nil
        }
        
        guard ((rating >= 0) && (rating <= 5)) else {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
