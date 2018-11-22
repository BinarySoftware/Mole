//
//  MainViewController.swift
//  Mole
//
//  Created by Maciej Mikołajek on 21/11/2018.
//  Copyright © 2018 Maciej Mikołajek. All rights reserved.
//

import Foundation
import AppKit
import CoreData

class MoleculeTableViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var tableView: NSTableView!
    var detailVC: MoleculeViewController? = nil
    
    /*
    var cdstore: CoreDataStore {
    if !_cdstore {
        _cdstore = CoreDataStore()
        }
        return _cdstore!
    }
    var _cdstore: CoreDataStore? = nil
    
    var cdh: CoreDataHelper {
    if !_cdh {
        _cdh = CoreDataHelper()
        }
        return _cdh!
    }
    var _cdh: CoreDataHelper? = nil
    */
    
    var defaultMolecules: [Molecule] = []
    
    var pdbFileList: [String] = [
        "1bbe",
        "1CF7",
        "1iyu",
        "1pse",
        "1CRN",
        "3INS",
        "3RFM",
        "132l",
        "ala",
        "atp",
        "b12",
        "benzene",
        "c2h2",
        "cys",
        "diamond",
        "dna",
        "fullerene",
        "gc-zdna",
        "graphite",
        "hemeco",
        "hemeo2",
        "igg1-cac",
        "lys195k",
        "nacl",
        "octane",
        "pcl5",
        "plp",
        "streptomycin",
        "trp",
        "zdna"
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tableView.reloadData()
        
        /* Core Data
        print("Load default molecules")
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Molecule")
        
        // fReq.predicate = NSPredicate(format:"name CONTAINS 'B' ")
        
        var sorter: NSSortDescriptor = NSSortDescriptor(key: "vendorId" , ascending: true)
        fReq.sortDescriptors = [sorter]
        
        var result = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        
        for resultItem : AnyObject in result {
            var mol = resultItem as Molecule
            NSLog("Fetched Molecule \(mol.vendorId)")
        }
        */
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
         return pdbFileList.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as! NSTableCellView
        
        cell.textField?.stringValue = self.pdbFileList[row]
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if self.tableView.selectedRow < pdbFileList.capacity && self.tableView.selectedRow >= 0 {
            guard let splitViewController = self.parent as? NSSplitViewController,
                let viewController = self.storyboard?.instantiateController(withIdentifier: "MoleculeViewController") as? MoleculeViewController
                else { return }
            
            let item = NSSplitViewItem(viewController: viewController)
        splitViewController.removeSplitViewItem(splitViewController.splitViewItems[1])
            splitViewController.addSplitViewItem(item)
            
            
            viewController.pdbFile = self.pdbFileList[self.tableView.selectedRow]
            viewController.load()
        }
    }
    
}
