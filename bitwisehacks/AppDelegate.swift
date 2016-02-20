//
//  AppDelegate.swift
//  bitwisehacks
//
//  Created by Robert Olsthoorn on 2/20/16.
//  Copyright © 2016 Robert Olsthoorn. All rights reserved.
//

import Cocoa

var isCalibrating = false
var paused = false;
var sensitivity = 0;

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    func httpGet(callback: (String, String?) -> Void) {
        
        let url: NSURL = NSURL(string: "https://api-m2x.att.com/v2/devices/286efac3f04c4a7433c6f94116f80a24/streams/posture/values?limit=2")!
        
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
        task.resume()
    }
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        
        var threshold = 45
        sensitivity = 0;
        
        if let button = statusItem.button {
            button.image = NSImage(named: "statusIcon")
            button.action = Selector("togglePopover:")
        }
        
        popover.contentViewController = QuotesViewController(nibName: "QuotesViewController", bundle: nil)
        let queue = NSOperationQueue()
        
        queue.addOperationWithBlock() {
            // do something in the background
            var calibrateCount = 3
            var calibrateSum = 0
            while (!paused) {
                self.httpGet(){ (data, error) -> Void in
                    if error != nil {
                        print("error\n")
                        print(error)
                    } else {
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
                            if isCalibrating {
                                print("calibrating...")
                                calibrateCount = calibrateCount - 1
                                calibrateSum = calibrateSum + sum/count
                                if 0 == calibrateCount {
                                    threshold = calibrateSum / 3
                                    isCalibrating = false
                                    print("new threshold")
                                    print(threshold)
                                    print("\n")
                                }
                            }
                                //Adding sensitivity from the slider to scale value
                            else if sum / count < threshold+sensitivity {
                                self.dimScreen()
                                sleep(5)
                                //print("dim")
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
    }
    
    func dimScreen(){
        let path = NSBundle.mainBundle().pathForResource("dim", ofType: "script")
        let url = NSURL(string: path!)
        let urlString: String = url!.path!

        let tempString = "\(urlString)"
        for _ in 1...20{
            let task = NSTask()
            task.launchPath="/usr/bin/osascript"
            task.arguments = [tempString]
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
    
    let popover = NSPopover()
    
    
}
