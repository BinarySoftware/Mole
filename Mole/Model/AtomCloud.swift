//
//  AtomCloud.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

/**
 * A rudimentary approach to speeding up bond creation between atoms.
 * An Octree/KD-Tree implementation is likely to speed this further.
 * The approach taken here is to divide the molecule into cubes of the same
 * wxhxl which is set to be the max bonding distance that 2 atoms would ever have.
 * Atoms are inserted into the cloud and associated with a cube at an index.
 * Cubes are indexed in a hash. 
 * 
 * Lookups are performed by determining the query atom's cube which is then taken 
 * as the center cube of a 27-cube cube. All neighbour's atoms are accumulated into 
 * the result set.
 */
import Foundation

class AtomCloud {
    // Set this to the largest possible distance 2 points would
    // be separated by
    var cubeLength: Float

    // Hashed cubes
    var grid: [String: AtomCloudCube] = [:]
    
    init(cubeLength: Float) {
        self.cubeLength = cubeLength
    }
    
    /**
     * Insert an Atom into this cloud.
     */
    func insert(atom: Atom) {
        // Convert the point to a cube coordinate
        let cx = floor(atom.position.x / cubeLength)
        let cy = floor(atom.position.y / cubeLength)
        let cz = floor(atom.position.z / cubeLength)
        
        // Create cube coordinate index
        let index = String("\(cx),\(cy),\(cz)")
        
        // Add the point to an existing or new cube
        if let cube = grid[index] {
            cube.objects.append(atom)
        } else {
            let cube: AtomCloudCube = AtomCloudCube(x: cx, y: cy, z: cz, w: cubeLength, h: cubeLength, l: cubeLength)
            cube.objects.append(atom)
            grid[index] = cube
        }
    }
    
    /**
     * Finds nearest neighbour Atoms by finding the cube owning the query atom
     * and then looking at all 27 cubes around it.
     */
    func nearest(atom: Atom) -> [Atom] {
        var result: [Atom] = []
        
        // Convert the point to a cube coordinate
        let cx = floor(atom.position.x / cubeLength)
        let cy = floor(atom.position.y / cubeLength)
        let cz = floor(atom.position.z / cubeLength)
        
        // Top layer
        findObjectsInCube(x:cx - 1, y: cy + 1, z: cz, result: &result)
        findObjectsInCube(x:cx - 1, y: cy + 1, z: cz - 1, result: &result)
        findObjectsInCube(x:cx, y: cy + 1, z: cz - 1, result: &result)
        findObjectsInCube(x:cx + 1, y: cy + 1, z: cz - 1, result: &result)
        findObjectsInCube(x:cx + 1, y: cy + 1, z: cz, result: &result)
        findObjectsInCube(x:cx + 1, y: cy + 1, z: cz + 1, result: &result)
        findObjectsInCube(x:cx, y: cy + 1, z: cz + 1, result: &result)
        findObjectsInCube(x:cx - 1, y: cy + 1, z: cz + 1, result: &result)
        findObjectsInCube(x:cx, y: cy + 1, z: cz, result: &result)
        
        // Center layer
        findObjectsInCube(x:cx - 1, y: cy, z: cz, result: &result)
        findObjectsInCube(x:cx - 1, y: cy, z: cz - 1, result: &result)
        findObjectsInCube(x:cx, y: cy, z: cz - 1, result: &result)
        findObjectsInCube(x:cx + 1, y: cy, z: cz - 1, result: &result)
        findObjectsInCube(x:cx + 1, y: cy, z: cz, result: &result)
        findObjectsInCube(x:cx + 1, y: cy, z: cz + 1, result: &result)
        findObjectsInCube(x:cx, y: cy, z: cz + 1, result: &result)
        findObjectsInCube(x:cx - 1, y: cy, z: cz + 1, result: &result)
        findObjectsInCube(x:cx, y: cy, z: cz, result: &result)

        // Bottom layer
        findObjectsInCube(x:cx - 1, y: cy - 1, z: cz, result: &result)
        findObjectsInCube(x:cx - 1, y: cy - 1, z: cz - 1, result: &result)
        findObjectsInCube(x:cx, y: cy - 1, z: cz - 1, result: &result)
        findObjectsInCube(x:cx + 1, y: cy - 1, z: cz - 1, result: &result)
        findObjectsInCube(x:cx + 1, y: cy - 1, z: cz, result: &result)
        findObjectsInCube(x:cx + 1, y: cy - 1, z: cz + 1, result: &result)
        findObjectsInCube(x:cx, y: cy - 1, z: cz + 1, result: &result)
        findObjectsInCube(x:cx - 1, y: cy - 1, z: cz + 1, result: &result)
        findObjectsInCube(x:cx, y: cy - 1, z: cz, result: &result)
        
        return result
    }
    
    /** Helper to return objects in a cube */
    func findObjectsInCube(x: Float, y: Float, z: Float, result: inout [Atom]) {
        // Create cube coordinate index
        let index = String("\(x),\(y),\(z)")
        
        // Add atoms
        if let cube = grid[index] {
            for atom in cube.objects {
                result.append(atom)
            }
        }
    }
}

/**
 * A cube in the cloud. The only important property here for the cloud and nearest
 * is objects. The coordinate and dimension properties are only used to draw the cubes
 * when debugging in the view.
 */
class AtomCloudCube {
    var objects: [Atom] = []
    
    var x: Float, y: Float, z: Float, w: Float, h: Float, l: Float
    var wx: Float, wy: Float, wz: Float
    
    init(x: Float, y: Float, z: Float, w: Float, h: Float, l: Float) {
        
        self.x = x
        self.y = y
        self.z = z
        self.w = w
        self.h = h
        self.l = l
        
        wx = x * w
        wy = y * h
        wz = z * l
    }
}
