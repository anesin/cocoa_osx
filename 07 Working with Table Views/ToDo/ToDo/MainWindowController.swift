//
//  MainWindowController.swift
//  ToDo
//
//  Created by anesin on 2015. 11. 29..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTableViewDataSource {

    @IBOutlet weak var textField: NSTextField!
    @IBAction func enterTextField(sender: NSTextField) {
        createNewItemWithName(sender.stringValue)
    }
    
    @IBAction func addToDo(sender: NSButton) {
        createNewItemWithName(textField.stringValue)
    }
    
    @IBOutlet weak var tableView: NSTableView!
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func createNewItemWithName(item: String) {
        print("create: \(item)")
        todoList.append(item)
        tableView.reloadData()
    }

    // MARK: - NSTableViewDataSource
    
    var todoList: [String] = []
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return todoList.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return todoList[row]
    }
    
}
