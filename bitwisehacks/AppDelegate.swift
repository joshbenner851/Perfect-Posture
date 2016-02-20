//
//  AppDelegate.swift
//  bitwisehacks
//
//  Created by Robert Olsthoorn on 2/20/16.
//  Copyright © 2016 Robert Olsthoorn. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    //
    //  main.swift
    //  dimmer
    //
    //  Created by Josh Benner on 2/20/16.
    //  Copyright © 2016 Josh Benner. All rights reserved.
    
    
    
//    func applicationDidFinishLaunching(aNotification: NSNotification) {
//        let icon = NSImage(named: "statusIcon")
//        icon?.template
//        
//        if let button = statusItem.button {
//            button.image = icon
//            button.action = Selector("printQuote:")
//            button.menu = statusMenu
//        }
//        
//        let menu = NSMenu()
//        
//        menu.addItem(NSMenuItem(title: "Print Quote", action: Selector("printQuote:"), keyEquivalent: "P"))
//        menu.addItem(NSMenuItem.separatorItem())
//        menu.addItem(NSMenuItem(title: "Quit Quotes", action: Selector("terminate:"), keyEquivalent: "q"))
//        
//        statusItem.menu = menu
//    }
    
    func httpGet(callback: (String, String?) -> Void) {
        
        let url: NSURL = NSURL(string: "https://api-m2x.att.com/v2/devices/286efac3f04c4a7433c6f94116f80a24/streams/posture/values?limit=10")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("83ffdd46ec1f3a278c0188dc034784d7", forHTTPHeaderField: "X-M2X-KEY")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    NSASCIIStringEncoding)!
                callback(result as String, nil)
            }
        }
        print("hi")
        task.resume()
    }
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        
        let threshold = 45
        
        if let button = statusItem.button {
            button.image = NSImage(named: "statusIcon")
            button.action = Selector("togglePopover:")
        }
        
        popover.contentViewController = QuotesViewController(nibName: "QuotesViewController", bundle: nil)
        while (true) {
            httpGet(){ (data, error) -> Void in
                if error != nil {
                    print("error\n")
                    print(error)
                } else {
                    print("data\n")
                    let data = data.dataUsingEncoding(NSUTF8StringEncoding)!
                    do {
                        let json: NSDictionary = try (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary)!
                        let values = json["values"] as! NSArray
                        var count = 0
                        var sum = 0
                        for val in values {
                            print(val["value"])
                            print("\n")
                            let angle = val["value"] as! Int
                            sum = sum + angle
                            count = count + 1
                        }
                        if sum / count < threshold {
                            self.dimScreen()
                        }
                    }
                    catch {
                        print("error")
                    }
                }
            }
        sleep(5)
        }
        
    }
    
    func dimScreen(){
        for _ in 1...20{
            let task = NSTask()
            task.launchPath="/usr/bin/osascript"
            //TODO Make locally called script file
            task.arguments = ["/Users/ethanraymond/Desktop/dim.script"]
            task.launch()
        }
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    //Prints Quote to Console
    func printQuote(sender: AnyObject) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) — \(quoteAuthor)")
    }
    
    let popover = NSPopover()
    
    
}
