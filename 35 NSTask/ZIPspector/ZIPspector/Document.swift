//
//  Document.swift
//  ZIPspector
//
//  Created by anesin on 2016. 5. 7..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class Document: NSDocument, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    
    var filenames: [String] = []
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
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
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    override func readFromURL(url: NSURL, ofType typeName: String) throws {
        // Which file are we getting the zipinfo for?
        let filename = url.path!
        
        // Prepare a task object
        let task = NSTask()
        task.launchPath = "/usr/bin/zipinfo"
        task.arguments = ["-1", filename]
        
        // Create the pipe to read from
        let outPipe = NSPipe()
        task.standardOutput = outPipe
        
        // Start the process
        task.launch()
        
        // Read the output
        let fileHandle = outPipe.fileHandleForReading
        let data = fileHandle.readDataToEndOfFile()
        
        // Make sure the task terminates normally
        task.waitUntilExit()
        let status = task.terminationStatus
        
        // Check status
        if status != 0 {
            let errorDomain = "com.bignerdranch.ProcessReturnCodeErrorDomain"
            let errorInfo = [NSLocalizedFailureReasonErrorKey : "zipinfo returned \(status)"]
            throw NSError(domain: errorDomain, code: 0, userInfo: errorInfo)
        }
        
        // Convert to a string
        let string = NSString(data: data, encoding: NSUTF8StringEncoding)!
        
        // Break the string into lines
        filenames = string.componentsSeparatedByString("\n")
        print("filenames = \(filenames)")
        
        // In case of revert
        tableView?.reloadData()
    }

    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return filenames.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return filenames[row]
    }
    
}

