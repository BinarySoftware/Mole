//
//  GameViewController.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import AppKit
import QuartzCore
import SceneKit

class MoleculeViewController: NSViewController {

    let pdbLoader = PDBLoader()
    var pdbFile: String = ""
    
    var state = State()
    var scene = SCNScene()
    var cameraNode = SCNNode()
    var molNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func load() {
        print("MVC viewDidLoad \(pdbFile)")
        molNode.removeFromParentNode()
        
        pdbLoader.loadMoleculeForPath(pdbFile: pdbFile)
        self.title = pdbLoader.molecule.name
        
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.zNear = 0.1
        cameraNode.position = SCNVector3(x: 0, y: 0, z: CGFloat(pdbLoader.molecule.maxN * 3))
        scene.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: CGFloat(pdbLoader.molecule.maxN))
        scene.rootNode.addChildNode(lightNode)
        
        let lightNode2 = SCNNode()
        lightNode2.light = SCNLight()
        lightNode2.light!.type = SCNLight.LightType.omni
        lightNode2.position = SCNVector3(x: 0, y: 0, z: CGFloat(-pdbLoader.molecule.maxN))
        scene.rootNode.addChildNode(lightNode2)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        switch state.mode {
        case .Sticks:
            RenderFactory.createSticks(colour: state.colour, molecule: pdbLoader.molecule, molNode: molNode)
        default:
            RenderFactory.createBalls(colour: state.colour, molecule: pdbLoader.molecule, molNode: molNode, forceSize: 0.0)
        }
        
        scene.rootNode.addChildNode(molNode)
        
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.pointOfView = cameraNode
        scnView.showsStatistics = true
        scnView.backgroundColor = NSColor.black
    }
    
    /**
     * Callback from ControlsViewController to notify that state was modified (possibly)
     * Need to check if state was changed to prevent wasted computation
     */
    func stateChanged() {
        // Remove current render
        molNode.removeFromParentNode()
        // Setup the new render
        molNode = SCNNode()

        // Render
        switch state.mode {
        case .Sticks:
            RenderFactory.createSticks(colour: state.colour, molecule: pdbLoader.molecule, molNode: molNode)
        default:
            RenderFactory.createBalls(colour: state.colour, molecule: pdbLoader.molecule, molNode: molNode, forceSize: 0.0)
        }
        
        scene.rootNode.addChildNode(molNode)
    }
}

extension MoleculeViewController: NSTouchBarDelegate {
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        return touchBar
    }
}
