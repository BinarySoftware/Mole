//
//  Chain.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import Foundation

class Chain {
    var id: String = ""
    var residues: [Residue] = []
    var residue: Residue = Residue()

    convenience init() {
        self.init(id: "NONE")
    }

    init(id:String) {
        self.id = id
    }
    
    func addAtom(atom: Atom) {
        // Create new residues as they occur
        if residue.name != atom.residue {
            residue = Residue(name: atom.residue)
            residues.append(residue)
        }
        
        residue.addAtom(atom: atom)
    }
}
