//
//  WebViewController.swift
//  RanchForecastSplit
//
//  Created by anesin on 2016. 4. 23..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController {
    
    var webView: WKWebView {
        return view as! WKWebView
    }
    
    override func loadView() {
        let webView = WKWebView()
        view = webView
    }
    
    func loadURL(url: NSURL) {
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
}
