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
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "statusIcon")
            button.action = Selector("togglePopover:")
        }
        
        popover.contentViewController = QuotesViewController(nibName: "QuotesViewController", bundle: nil)
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
