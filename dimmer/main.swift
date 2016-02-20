//
//  main.swift
//  dimmer
//
//  Created by Josh Benner on 2/20/16.
//  Copyright © 2016 Josh Benner. All rights reserved.
//

import Foundation

print("Hello, World!")

//for index in 1...5{
//    let task = NSTask()
//    task.launchPath = "/usr/bin/osascript"
//    task.arguments = ["/Users/joshbenner/Desktop/dim.script"]
//    
//    task.launch()
//}

func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
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

let url:NSURL = NSURL(string: "http://api-m2x.att.com/v2/devices/286efac3f04c4a7433c6f94116f80a24/streams/posture/values")!
//http://api-m2x.att.com/v2/devices/286efac3f04c4a7433c6f94116f80a24/streams/hackers4lyfe/values
var request = NSMutableURLRequest(URL: url)
request.HTTPMethod = "GET"

request.addValue("application/json", forHTTPHeaderField: "Content-Type")
request.addValue("83ffdd46ec1f3a278c0188dc034784d7", forHTTPHeaderField: "X-M2X-KEY")
//request.addValue("a1ee3f921f91ea334dd4b03386284375", forHTTPHeaderField: "X-M2X-KEY")

httpGet(request){
    (data, error) -> Void in
    if error != nil {
        print("error\n")
        print(error)
    } else {
        print("data\n")
        let data = data.dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let json: NSDictionary = try (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary)!
            print(json["values"])
            print("\n")
        }
        catch {
            print("error")
        }
    }
}

print("after task\n")

while (true) {}