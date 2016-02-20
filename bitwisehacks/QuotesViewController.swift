import Cocoa
import Foundation

class QuotesViewController: NSViewController {
    @IBOutlet var textLabel: NSTextField!
    
    
    @IBOutlet weak var slider: NSSliderCell!
    
    @IBOutlet weak var labelPause: NSButton!

    @IBOutlet weak var calibrateButton: NSButton!
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

    @IBAction func calibrate(sender: NSButton) {
        isCalibrating = true
        print("CALIBRATE BITCH")
    }
    @IBAction func togglePause(sender: NSButton) {
        if(!paused){
            paused = true;
            labelPause.title = "Play"
        }
        else{
            paused = false;
            labelPause.title = "Pause"
        }
    }
    
    @IBAction func changeSlider(sender: NSSlider) {
        print(sender.integerValue)
        sensitivity = sender.integerValue
    }
    
}

