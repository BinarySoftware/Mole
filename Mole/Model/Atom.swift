//
//  Atom.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import Foundation

class Atom : Hashable {
    
    var id: String  = ""
    var name: String  = ""
    var residue: String  = ""
    var chain: String  = ""
    var element: String  = ""
    var position = Point3D()
    var valence: Float = 0.0
    var remoteness: String = "" // A, B, G, D, E, Z, H
    
    var hashValue : Int {
        get {
            return "\(self.position.x)\(self.position.y)\(self.position.z)".hashValue
        }
    }
    
    init(id: String, name: String, residue: String, chain: String, element: String, x: Float, y: Float, z: Float, remoteness: String) {
        
        self.id = id
        self.name = name
        self.residue = residue
        self.chain = chain
        self.element = element
        
        position.x = x
        position.y = y
        position.z = z
        
        self.remoteness = remoteness
    }
}

func ==(lhs: Atom, rhs: Atom) -> Bool {
    
    return lhs.hashValue == rhs.hashValue
}
