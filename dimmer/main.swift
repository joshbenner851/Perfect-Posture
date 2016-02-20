//
//  main.swift
//  dimmer
//
//  Created by Josh Benner on 2/20/16.
//  Copyright © 2016 Josh Benner. All rights reserved.
//

import Foundation

print("Hello, World!")

for index in 1...5{
    let task = NSTask()
    task.launchPath = "/usr/bin/osascript"
    task.arguments = ["/Users/joshbenner/Desktop/dim.script"]
    
    task.launch()
}

