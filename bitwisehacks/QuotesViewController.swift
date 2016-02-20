import Cocoa
import Foundation

class QuotesViewController: NSViewController {
    @IBOutlet var textLabel: NSTextField!
    
//    let quotes = Quote.all
    
//    var currentQuoteIndex: Int = 0 {
//        didSet{
//            updateQuote()
//        }
//    }
    
//    override func viewWillAppear(){
//        super.viewWillAppear()
//        currentQuoteIndex = 0
//    }
    
//    func updateQuote(){
//        textLabel.stringValue = String(quotes[currentQuoteIndex])
//    }
    
    //print("Hello, World!")
    

}

// MARK: Actions

extension QuotesViewController {
    
    @IBAction func quit(sender: NSButton) {
        NSApplication.sharedApplication().terminate(sender)
    }
    
    @IBAction func dimScreen(sender: NSButton){
        let path = NSBundle.mainBundle().pathForResource("dim", ofType: "script")
        let url = NSURL(string: path!)
        let urlString: String = url!.path!
//        
//        let contentData = NSFileManager.defaultManager().contentsAtPath(path!)
//        
//        let content = NSString(data: url!, encoding: NSUTF8StringEncoding) as? String
        
        let tempString = "\(urlString)"
        for _ in 1...20{
        let task = NSTask()
        task.launchPath="/usr/bin/osascript"
        //TODO Make locally called script file
           
        task.arguments = [tempString]
        task.launch()
        
        
        
        }
    }
    
    //
//    httpGet(request){ (data, error) -> Void in
//    if error != nil {
//    print("error\n")
//    print(error)
//    } else {
//    print("data\n")
//    let data = data.dataUsingEncoding(NSUTF8StringEncoding)!
//    do {
//    let json: NSDictionary = try (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary)!
//    print(json["values"])
//    print("\n")
//    }
//    catch {
//    print("error")
//    }
//    }
//    }
    
    //request.addValue("a1ee3f921f91ea334dd4b03386284375", forHTTPHeaderField: "X-M2X-KEY")
    
//    print("after task\n")
//    
//    while (true) {}
    
    
}

