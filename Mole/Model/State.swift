//
//  State.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import Foundation

enum RenderModeEnumeration {
    case Balls
    case Sticks
}

enum RenderColourEnumeration {
    case CPK
    case Amino
}

class State {
    var mode: RenderModeEnumeration = RenderModeEnumeration.Sticks
    var colour: RenderColourEnumeration = RenderColourEnumeration.CPK
}
