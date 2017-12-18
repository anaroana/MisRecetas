//
//  Recipe.swift
//  MisRecetas
//
//  Created by Ana Rocha on 12/12/17.
//  Copyright © 2017 Kite. All rights reserved.
//

import Foundation
import UIKit

class Recipe: NSObject {
    var name: String!
    var image: UIImage!
    var time: Int!
    var ingredients: [String]!
    var steps: [String]!
    
    var rating: String! 
    
    init(name: String, image: UIImage, time: Int, ingredients: [String], steps: [String]) {
        self.name = name
        self.image = image
        self.time = time
        self.ingredients = ingredients
        self.steps = steps
        self.rating = "rating"
    }
}
