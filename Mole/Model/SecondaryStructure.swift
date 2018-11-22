//
//  SecondaryStructure.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import Foundation

class SecondaryStructure {
    var id: String = ""
    
    convenience init() {
        self.init(id: "NONE")
    }
    
    init(id:String) {
        self.id = id
    }
}
