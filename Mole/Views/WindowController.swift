//
//  WindowController.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @IBAction func ColourParticles(_ sender: Any) {
        guard let splitViewController = self.contentViewController as? NSSplitViewController
            else { return }
        
        guard let sceneVC = splitViewController.splitViewItems[1].viewController as? MoleculeViewController else { return }
       
        sceneVC.state.colour = RenderColourEnumeration.CPK
        sceneVC.stateChanged()
    }
    
    @IBAction func ColourAmino(_ sender: Any) {
        guard let splitViewController = self.contentViewController as? NSSplitViewController
            else { return }
        
        guard let sceneVC = splitViewController.splitViewItems[1].viewController as? MoleculeViewController else { return }
        
        sceneVC.state.colour = RenderColourEnumeration.Amino
        sceneVC.stateChanged()
    }
    
    @IBAction func ShowStciks(_ sender: Any) {
        guard let splitViewController = self.contentViewController as? NSSplitViewController
            else { return }
        
        guard let sceneVC = splitViewController.splitViewItems[1].viewController as? MoleculeViewController else { return }
        
        sceneVC.state.mode = RenderModeEnumeration.Sticks
        sceneVC.stateChanged()
    }
    
    @IBAction func ShowBalls(_ sender: Any) {
        guard let splitViewController = self.contentViewController as? NSSplitViewController
            else { return }
        
        guard let sceneVC = splitViewController.splitViewItems[1].viewController as? MoleculeViewController else { return }
        
        sceneVC.state.mode = RenderModeEnumeration.Balls
        sceneVC.stateChanged()
    }
}
