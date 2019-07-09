//
//  Meal.swift
//  FoodTracker
//
//  Created by UAG on 2019/7/8.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit
import os.log

class Meal : NSObject, NSCoding{
    //MAKE: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: property.name)
        aCoder.encode(photo, forKey: property.photo)
        aCoder.encode(rating, forKey: property.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: property.name) as? String else {
            os_log( "Unable to decode the name for the Meal object", log: OSLog.default, type : .debug)
            return nil
        }
        
        //Because photo is an optional property of Meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: property.photo) as? UIImage
        
        guard let rating = aDecoder.decodeObject(forKey: property.rating) as? Int else{
              os_log( "Unable to decode the rating for the Meal object", log: OSLog.default, type : .debug)
            return nil
        }
        
        self.init(name: name, photo: photo, rating: rating)
        
    }
    
    //MARK: properties
    var name: String
    var photo: UIImage?
    var rating:Int
    
    //MARK: Archiving path
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archivingURL = DocumentDirectory.appendingPathComponent("meals")
    //MARK: type
    struct property {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
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
