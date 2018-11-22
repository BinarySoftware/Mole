//
//  SplitViewController.swift
//  Mole
//
//  Created by Maciej Mikołajek on 06.05.2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    @IBOutlet weak var tableView: NSSplitViewItem!
    @IBOutlet weak var detail: NSSplitViewItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Join leftVC ro rightVC
        if let leftVC = tableView.viewController as? MoleculeTableViewController
        {
            if let rightVC = detail.viewController as? MoleculeViewController
            {
                leftVC.detailVC = rightVC
            }
        }
    }
    
}
