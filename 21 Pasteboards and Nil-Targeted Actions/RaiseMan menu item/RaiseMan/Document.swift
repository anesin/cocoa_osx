//
//  Document.swift
//  RaiseMan
//
//  Created by anesin on 2015. 12. 13..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa

private var KVOContext: Int = 0

class Document: NSDocument {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var arrayController: NSArrayController!
    
    var employees: [Employee] = [] {
        willSet {
            for employee in employees {
                stopObservingEmployee(employee)
            }
        }
        didSet {
            for employee in employees {
                startObservingEmployee(employee)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addEmployee(sender: NSButton) {
        let windowController = windowControllers[0]
        let window = windowController.window!
        
        let endedEditing = window.makeFirstResponder(window)
        if !endedEditing {
            print("Unable to end editing")
            return
        }
        
        let undo: NSUndoManager = undoManager!
        
        // Has as edit occurred already in this event?
        if undo.groupingLevel > 0 {
            // Close the last group
            undo.endUndoGrouping()
            // Open a new group
            undo.beginUndoGrouping()
        }
        
        // Create the object
        let employee = arrayController.newObject() as! Employee
        
        // Add it to the array controller's contentArray
        arrayController.addObject(employee)
        
        // Re-sort (in case the user has sorted a column)
        arrayController.rearrangeObjects()
        
        // Get the sorted array
        let sortedEmployees = arrayController.arrangedObjects as! [Employee]
        
        // Find the object just added
        let row = sortedEmployees.indexOf(employee)!
        
        // Begin the edit in the first column
        print("starting edit of \(employee) in row \(row)")
        tableView.editColumn(0, row: row, withEvent: nil, select: true)
    }
    
    @IBAction func removeEmployees(sender: NSButton) {
        removeEmployeesCore(sender.window!)
    }
    
    @IBAction func removeEmployeesMenu(sender: AnyObject?) {
        removeEmployeesCore(tableView.window!)
    }
    
    override func validateMenuItem(menuItem: NSMenuItem) -> Bool {
        if menuItem.action == Selector("removeEmployeesMenu:") {
            let selectedPeople: [Employee] = arrayController.selectedObjects as! [Employee]
            return selectedPeople.count > 0
        }
        return super.validateMenuItem(menuItem)
    }
    
    func removeEmployeesCore(window: NSWindow) {
        let selectedPeople: [Employee] = arrayController.selectedObjects as! [Employee]
        let alert = NSAlert()
        alert.messageText = "Do you really want to remove these people?"
        alert.informativeText = "\(selectedPeople.count) people will removed."
        alert.addButtonWithTitle("Remove")
        alert.addButtonWithTitle("Cancel")
        alert.beginSheetModalForWindow(window, completionHandler: { (response) -> Void in
            // If the user choose "Remove", tell the array controller to delete the people
            switch response {
            case NSAlertFirstButtonReturn:
                // The array controller will delete the selected objects
                // The argument to remove() is ignored
                self.arrayController.remove(nil)
            default:
                break
            }
        })
    }

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }

    override func dataOfType(typeName: String) throws -> NSData {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        
        // Edn editing
        tableView.window?.endEditingFor(nil)
        
        // Create an NSData object from the employees array
        return NSKeyedArchiver.archivedDataWithRootObject(employees)
    }
    
    override func readFromData(data: NSData, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.

        print("About to read data of type \(typeName).")
        employees = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Employee]
    }
    
    // MARK: - Accessors
    
    func insertObject(employee: Employee, inEmployeesAtIndex index: Int) {
        print("adding \(employee) to the employees array")
        
        // Add the inverse of this operation to the undo stack
        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(employees.count)
        if !undo.undoing {
            print("Add Person")
            undo.setActionName("Add Person")
        }
        
        employees.append(employee)
    }
    
    func removeObjectFromEmployeesAtIndex(index: Int) {
        let employee: Employee = employees[index]
        print("removing \(employee) from the employees array")
        
        // Add the inverse of this operation to the undo stack
        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).insertObject(employee, inEmployeesAtIndex: index)
        if !undo.undoing {
            print("Remove Person")
            undo.setActionName("Remove Person")
        }
        
        // Remove the Employee from the array
        employees.removeAtIndex(index)
    }
    
    // MARK: - Key Value Observing
    
    func startObservingEmployee(employee: Employee) {
        employee.addObserver(self, forKeyPath: "name", options: .Old, context: &KVOContext)
        employee.addObserver(self, forKeyPath: "raise", options: .Old, context: &KVOContext)
    }
    
    func stopObservingEmployee(employee: Employee) {
        employee.removeObserver(self, forKeyPath: "name", context: &KVOContext)
        employee.removeObserver(self, forKeyPath: "raise", context: &KVOContext)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context != &KVOContext {
            // If the context does not match, this message
            // must be intended for our superclass.
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        
        var oldValue: AnyObject? = change![NSKeyValueChangeOldKey]
        if oldValue is NSNull {
            oldValue = nil
        }
        
        let undo: NSUndoManager = undoManager!
        print("oldValue=\(oldValue)")
        undo.prepareWithInvocationTarget(object!).setValue(oldValue, forKeyPath: keyPath!)
    }
    
    // MARK: - NSWindowDelegate
    
    func windowWillClose(notification: NSNotification) {
        employees = []
    }

}

