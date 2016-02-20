import Cocoa
import Foundation

class QuotesViewController: NSViewController {
    @IBOutlet var textLabel: NSTextField!
    
    

}

extension QuotesViewController {
    
    @IBAction func quit(sender: NSButton) {
        NSApplication.sharedApplication().terminate(sender)
    }
    
    @IBAction func dimScreen(sender: NSButton){
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

    @IBAction func calibrate(sender: AnyObject) {
        isCalibrating = true
        print("CALIBRATE BITCH")
    }

}

