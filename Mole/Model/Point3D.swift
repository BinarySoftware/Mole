//
//  Point3D.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import Foundation

/**
 *Structure for representation of particle in 3 dimensions
 **/
struct Point3D: Hashable {
    var x: Float = 0.0,
        y: Float = 0.0,
        z: Float = 0.0
    
    var hashValue : Int {
        get {
            return "\(self.x)\(self.y)\(self.z)".hashValue
        }
    }
    
    init(x: Float = 0.0, y: Float = 0.0, z: Float = 0.0) {
        self.x = x
        self.y = y
        self.z = z
    }
}

func ==(lhs: Point3D, rhs: Point3D) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
