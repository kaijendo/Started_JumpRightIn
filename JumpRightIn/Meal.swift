//
//  Meal.swift
//  JumpRightIn
//
//  Created by Kai Jendo on 6/11/17.
//  Copyright © 2017 KaiJendo. All rights reserved.
//

import Foundation
import UIKit
import os.log
class Meal: NSObject, NSCoding {
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If it's can't decode a name string, the initializer should fails
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object", log: OSLog.default, type: .default)
            return nil
        }
        // Because photo is an optional property of Meal, just use codinational cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
        
    }
    
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // Initialization should fail
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        // Initalization stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    
    
}
